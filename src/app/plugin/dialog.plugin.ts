import { registerPlugin } from '@capacitor/core'

interface DialogOption {
  title: string
  message: string
  selectedDate: string
  maxDate: string
}

interface DialogResponse {
  selectedDate: string
}

export interface DialogPlugin {
  showDialog(options: DialogOption): Promise<DialogResponse>
}

// export interface DialogPlugin {
//   showDialog(options: { title: string, message: string, selectedDate: string, maxDate: string }): Promise<{ selectedDate: string }>;
// }

const DobDialog = registerPlugin<DialogPlugin>('DobDialog')

export default DobDialog
