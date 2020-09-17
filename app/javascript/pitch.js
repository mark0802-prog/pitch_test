import * as Tone from 'tone'

function pitch() {
  const synth = new Tone.Synth().toDestination()
  const buttons = document.querySelectorAll("button")
  buttons.forEach((button) => {
    button.addEventListener("click", () => {
      const note = button.innerHTML
      synth.triggerAttackRelease(note, "4n")
    })
  })
}

if (document.URL.match(/pitches/)) {
  addEventListener("load", pitch)
}
