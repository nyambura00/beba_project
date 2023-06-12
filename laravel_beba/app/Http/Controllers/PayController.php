<?php

namespace App\Http\Controllers;

use App\Models\StkRequest;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;
use Throwable;

class PayController extends Controller
{
    // Get your access token
    public function token ()
    {
        $consumerKey = 'aalxESm5HyBJfb2qAGn1iK1XzNUoyWX1';
        $consumerSecret = 'cydJhLzRXRNSAiCv';
        $url = 'https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials';

        $response = Http::withBasicAuth($consumerKey,$consumerSecret)->get($url);
        return $response['access_token'];
    }

    // Initiate STK Push
    public function initiateStkPush()
    {
        $accessToken = $this->token();
        $url = 'https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest';
        $LipaNaMpesaPasskey = 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919';
        $BusinessShortCode = 174379;
        $Timestamp = Carbon::now()->format('YmdHis');
        $Password = base64_encode($BusinessShortCode.$LipaNaMpesaPasskey.$Timestamp);
        $TransactionType = 'CustomerPayBillOnline';
        $Amount = 1;
        $PartyA = 254700482395;
        $PartyB = 174379;
        $PhoneNumber = 254700482395;
        $CallBackURL = 'https://ea98-41-90-66-75.ngrok-free.app/mpesa/stkCallback';   
        $AccountReference = 'Scheduled Travels';
        $TransactionDesc = 'Transport Payment'; 
        
        $response = Http::withToken($accessToken)->post($url, [
            'BusinessShortCode' => $BusinessShortCode,
            'Password' => $Password,
            'Timestamp' => $Timestamp,
            'TransactionType' => $TransactionType,
            'Amount' => $Amount,
            'PartyA' => $PartyA,
            'PartyB' => $PartyB,
            'PhoneNumber' => $PhoneNumber,
            'CallBackURL' => $CallBackURL,
            'AccountReference' => $AccountReference,
            'TransactionDesc' => $TransactionDesc,
        ]);

        $res = json_decode($response);
        $ResponseCode = $res->ResponseCode;

        if($ResponseCode == 0){
            $MerchantRequestID = $res->MerchantRequestID;
            $CheckoutRequestID = $res->CheckoutRequestID;
            $CustomerMessage = $res->CustomerMessage;

            //Save to Database
            $payment = new StkRequest;
            $payment->phoneNumber = $PhoneNumber;
            $payment->amount = $Amount;
            $payment->reference = $AccountReference;
            $payment->description = $TransactionDesc;
            $payment->MerchantRequestID = $MerchantRequestID;
            $payment->CheckoutRequestID = $CheckoutRequestID;
            $payment->status = 'Requested';
            $payment->save();

            return $CustomerMessage;
        }
    }

    //Handle the callback Response
    public function stkCallback() 
    {
        $data = file_get_contents('php://input');
        Storage::disk('local')->put('stk.txt',$data);

        $response = json_decode($data);
        $resultCode = $response->Body->stkCallback->ResultCode;

        if($resultCode == 0) {
            $MerchantRequestID = $response->Body->stkCallback->MerchantRequestID;
            $CheckoutRequestID = $response->Body->stkCallback->CheckoutRequestID;
            $ResultDesc = $response->Body->stkCallback->ResultDesc;
            $Amount = $response->Body->stkCallback->CallbackMetadata->Item[0]->Value;
            $MpesaReceiptNumber = $response->Body->stkCallback->CallbackMetadata->Item[1]->Value;
            $TransactionDate = $response->Body->stkCallback->CallbackMetadata->Item[3]->Value;
            $PhoneNumber = $response->Body->stkCallback->CallbackMetadata->Item[4]->Value;
        
            $payment = StkRequest::where('CheckoutRequestID', $CheckoutRequestID)->firstOrFail();
            $payment->status = 'Paid';
            $payment->TransactionDate = $TransactionDate;
            $payment->MpesaReceiptNumber = $MpesaReceiptNumber;
            $payment->ResultDesc = $ResultDesc;
            $payment->save();
        } else {
            $CheckoutRequestID = $response->Body->stkCallback->CheckoutRequestID;
            $ResultDesc = $response->Body->stkCallback->ResultDesc;
            $payment = StkRequest::where('CheckoutRequestID', $CheckoutRequestID)->firstOrFail();

            $payment->ResultDesc = $ResultDesc;
            $payment->status = 'Fail';
            $payment->save();
        }
    }

    public function stkQuery ()
    {
        $accessToken = $this->token();
        $BusinessShortCode = 174379;
        $LipaNaMpesaPasskey = 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919';
        $url = 'https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest';
        $Timestamp = Carbon::now()->format('YmdHis');
        $Password = base64_encode($BusinessShortCode.$LipaNaMpesaPasskey.$Timestamp);
        $CheckoutRequestID = 'ws_CO_23052023213439697700482395';

        $response = Http::withToken($accessToken)->post($url, [
            'BusinessShortCode' => $BusinessShortCode,
            'Timestamp' => $Timestamp,
            'Password' => $Password,
            'CheckoutRequestID' => $CheckoutRequestID,
        ]);

        return $response;
    }
    
}
