import * as Tone from 'tone'

function quiz() {
  const synth = new Tone.Synth().toDestination()
  const button = document.getElementById("button")
  const note = ["E3", "F3", "F#3", "G3", "G#3", "A3", "A#3", "B3", "C4", "C#4", "D4", "D#4"]
  const answers = document.querySelectorAll(".answer")
  const correct = document.getElementById("correct")

  button.addEventListener("click", () => {
    const note_random = note[Math.floor(Math.random()*note.length)]
    synth.triggerAttackRelease(note_random, "4n")
    console.log(note_random) //cheat

    answers.forEach((answer) => {
      answer.addEventListener("click", () => {
        const note_answer = answer.innerHTML
        if (note_answer==note_random) {
          correct.innerHTML = `<p>Correct!</p>`
        } else {
          correct.innerHTML = `<p>Wrong!</p>`
        }
      })
    })
  })
}

if (document.URL.match(/quizes/)) {
  addEventListener("load", quiz)
}
