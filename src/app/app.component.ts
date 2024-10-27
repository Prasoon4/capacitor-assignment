import { Component } from '@angular/core'
import NativeDialog from './plugin/dialog.plugin'
import PreferenceUtils from './utils/preference'
import { DatePipe } from '@angular/common'

@Component({
  selector: 'app-root',
  standalone: true,
  templateUrl: './app.component.html',
  styleUrl: './app.component.css',
  providers: [DatePipe],
})
export class AppComponent {
  selectedDate = ''
  private maxDate = ''

  constructor(private datePipe: DatePipe) {
    // setting 18 years date as max date
    this.maxDate = this.calculateDateYearsAgo(18)

    // set saved date of birth as default date. If date of birth is not found, then set 30 years ago date
    this.selectedDate =
      PreferenceUtils.getDateOfBirth() || this.calculateDateYearsAgo(30)
  }

  onDateClick() {
    NativeDialog.showDialog({
      title: 'Date of birth',
      message: 'You need to be 18 years of the age to use Natural Cycles',
      selectedDate: this.selectedDate,
      maxDate: this.maxDate,
    }).then((res) => {
      this.selectedDate = res.selectedDate
      PreferenceUtils.saveDateOfBirth(res.selectedDate)
    })
    console.log('clicked')
  }

  /**
   * Calculate years ago date in 'yyyy-MM-dd' format from current date
   *
   * @param years number of years
   * @returns formatted date
   */
  calculateDateYearsAgo(years: number): string {
    const today = new Date()

    // Checking if currect day is a leap year
    const isLeapDay = today.getMonth() === 1 && today.getDate() === 29

    // substracting years
    today.setFullYear(today.getFullYear() - years)

    if (isLeapDay && today.getMonth() === 2) {
      // if date changes march 1, then changing it again to 28 Feb
      today.setMonth(1)
      today.setDate(28)
    }
    return this.datePipe.transform(today, 'yyyy-MM-dd') || ''
  }
}
