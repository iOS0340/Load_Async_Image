//
//  Constants.swift
//  async_image_load
//
//  Created by Bhavesh Patel on 15/04/24.
//

import Foundation

//  MARK: - API CONST

let CLIENT_ID = "o7bvmX04qYOm43Okahw7jroC4zagxl2gONFmfKac7oU"
let BASEURL = "https://api.unsplash.com/"
let PHOTOS_END_POINT = "photos?client_id="
let PER_PAGE_IMAGE_COUNT = 30
var isNetworkAvailable = false


//  MARK: - Error Messages
let API_NOT_FOUND = "The requested resource was not found on the server. Please contact the support team"
let UNAUTH_USER = "Unauthorised user"
let SOME_WENT_WRONG = "Something went worng. Please try later!"
let SERVER_NOT_FOUND = "Sorry, couldn't reach our server."
let INVALID_DATA = "Invalid Data Received!"
let AUTH_FAIL = "Authentication Failed. Please check our application key."
let DATA_NOT_FOUND = "Data not found"
let CHECK_URL = "Please check URL"
let NO_INTERNET = "Internet connection not available"

//  MARK: - CONST LABEL

let LOADING = "Loading..."
let ALL_PHOTOS_LOADED = "All Images are loaded!"
