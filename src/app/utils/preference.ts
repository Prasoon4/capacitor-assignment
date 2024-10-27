export default class PreferenceUtils {
  static saveDateOfBirth(dob: string) {
    localStorage.setItem('dob', dob)
  }

  static getDateOfBirth(): string | null {
    return localStorage.getItem('dob')
  }
}
