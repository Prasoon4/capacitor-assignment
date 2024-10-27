import { TestBed } from '@angular/core/testing'
import { AppComponent } from './app.component'

describe('AppComponent', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AppComponent],
    }).compileComponents()
  })

  it('should create the app', () => {
    const fixture = TestBed.createComponent(AppComponent)
    const app = fixture.componentInstance
    expect(app).toBeTruthy()
  })

  it(`should have displayed 30 years date`, () => {
    const fixture = TestBed.createComponent(AppComponent)
    const app = fixture.componentInstance
    let displayedDate = app.calculateDateYearsAgo(30)
    expect(app.selectedDate).toEqual(displayedDate)
  })

  it('should render all text', () => {
    const fixture = TestBed.createComponent(AppComponent)
    fixture.detectChanges()
    const compiled = fixture.nativeElement as HTMLElement
    expect(compiled.querySelector('div')?.textContent).toContain(
      'Set your date of birth',
    )
    expect(compiled.querySelector('div')?.textContent).toContain(
      'Date of birth',
    )
    expect(compiled.querySelector('div')?.textContent).toContain(
      'You must be 18 years of age to use the natural Cycles.',
    )
  })
})
