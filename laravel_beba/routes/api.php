<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PayController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::prefix('api')->group(function () {
    Route::get('mpesa/token', [PayController::class, 'token']);
    Route::get('mpesa/initiateStk', [PayController::class, 'initiateStkPush']);
    Route::post('mpesa/stkCallback', [PayController::class, 'stkCallback']);
    Route::get('mpesa/stkquery', [PayController::class, 'stkQuery']);
});

Route::get('pay', [PayController::class, 'stk']);
