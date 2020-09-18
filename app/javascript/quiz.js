import * as Tone from 'tone'

function quiz() {
  const synth = new Tone.Synth().toDestination()
  const button = document.getElementById("button")
  const note = ["E3", "F3", "F#3", "G3", "G#3", "A3", "A#3", "B3", "C4", "C#4", "D4", "D#4"]
  const answers = document.querySelectorAll(".answer")
  const correct = document.getElementById("correct")
  const chime_correct = document.getElementById("chime_correct")
  const chime_wrong = document.getElementById("chime_wrong")

  button.addEventListener("click", () => {
    this.note_random = note[Math.floor(Math.random()*note.length)]
    synth.triggerAttackRelease(note_random, "4n")
    console.log(note_random) //cheat
  })

  answers.forEach((answer) => {
    function correct_or_wrong () {
      const note_answer = answer.innerHTML
      if (note_answer==note_random) {
        correct.innerHTML = '<p>Correct!</p>'
        chime_correct.play()
        console.log("a")
      } else {
        correct.innerHTML = '<p>Wrong!</p>'
        chime_wrong.play()
        console.log("b")
      }
    }
    answer.addEventListener("click", correct_or_wrong)
  })
}

if (document.URL.match(/quizes/)) {
  addEventListener("load", quiz)
}
