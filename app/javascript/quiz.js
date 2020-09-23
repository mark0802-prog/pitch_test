import * as Tone from 'tone'

function quiz() {
  const synth = new Tone.Synth().toDestination()
  const correct_count = document.getElementById("correct_count")
  const wrong_count = document.getElementById("wrong_count")
  const correct_rate = document.getElementById("correct_rate")
  const total_time = document.getElementById("total_time")
  const current_total_time = parseInt(total_time.value)
  const average_time = document.getElementById("average_time")
  const start_button = document.getElementById("start_button")
  const again_button = document.getElementById("again_button")
  const note = ["E3", "F3", "F#3", "G3", "G#3", "A3", "A#3", "B3", "C4", "C#4", "D4", "D#4"]
  const answers = document.querySelectorAll(".answer_button")
  const correct = document.getElementById("correct")
  const chime_correct = document.getElementById("chime_correct")
  const chime_wrong = document.getElementById("chime_wrong")
  const submit = document.getElementById("submit")

  again_button.style.display = "none"
  correct_rate.innerHTML = Math.round(parseInt(correct_count.value) / (parseInt(correct_count.value) + parseInt(wrong_count.value)) * 100)
  average_time.innerHTML = Math.round(parseInt(total_time.value) / parseInt(correct_count.value))

  start_button.addEventListener("click", () => {
    if (!total_time.getAttribute("set")) {
      const now = Tone.now()
      setInterval(() => total_time.value = current_total_time + Math.floor(Tone.now() - now), 1000);
    }
    total_time.setAttribute("set", true)

    this.note_random = note[Math.floor(Math.random()*note.length)]
    synth.triggerAttackRelease(note_random, "4n")
    answers.forEach((answer) => {
      answer.style.visibility = "visible"
    })
    start_button.style.display = "none"
    again_button.style.display = "inline"
    console.log(note_random) //cheat
  })

  again_button.addEventListener("click", () => {
    synth.triggerAttackRelease(note_random, "4n")
  })

  answers.forEach((answer) => {
    answer.style.visibility = "hidden"
    function correct_or_wrong () {
      const note_answer = answer.innerHTML
      if (note_answer==note_random) {
        correct.innerHTML = '<p>Correct!</p>'
        correct_count.value = parseInt(correct_count.value) + 1
        correct_rate.innerHTML = Math.round(parseInt(correct_count.value) / (parseInt(correct_count.value) + parseInt(wrong_count.value)) * 100)
        average_time.innerHTML = Math.round(parseInt(total_time.value) / parseInt(correct_count.value))
        chime_correct.play()
        if (submit != null) {
          submit.click()
        }
        start_button.style.display = "inline"
        again_button.style.display = "none"
        answers.forEach((answer) => {
          answer.style.visibility = "hidden"
        })
      } else {
        correct.innerHTML = '<p>Wrong!</p>'
        wrong_count.value = parseInt(wrong_count.value) + 1
        correct_rate.innerHTML = Math.round(parseInt(correct_count.value) / (parseInt(correct_count.value) + parseInt(wrong_count.value)) * 100)
        chime_wrong.play()
        if (submit != null) {
          submit.click()
        }
      }
    }
    answer.addEventListener("click", correct_or_wrong)
  })
}

if (document.URL.match(/quizes/)) {
  addEventListener("DOMContentLoaded", quiz)
}
