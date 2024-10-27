package com.example.dobpicker.utils

import java.text.ParseException
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

object DateUtils {

    private const val DATE_FORMAT = "yyyy-MM-dd"
    val dateFormatter = SimpleDateFormat(DATE_FORMAT, Locale.US)

    fun parseDate(strDate: String): Date? {

        var date: Date? = null
        try {
            date = dateFormatter.parse(strDate)
        } catch (e: ParseException) {
            e.printStackTrace()
        }
        return date
    }
}
