import * as Tone from 'tone'

function calc_rate(x, y) {
  return Math.round(parseInt(x) / (parseInt(x) + parseInt(y)) * 100)
}

function quiz() {
  const synth = new Tone.Synth().toDestination()
  const total_correct_count = document.getElementById("total_correct_count")
  const total_wrong_count = document.getElementById("total_wrong_count")
  const total_correct_rate = document.getElementById("total_correct_rate")
  const total_time = document.getElementById("total_time")
  let current_total_time = parseFloat(total_time.value)
  const total_average_time = document.getElementById("total_average_time")
  const daily_correct_count = document.getElementById("daily_correct_count")
  const daily_wrong_count = document.getElementById("daily_wrong_count")
  const daily_correct_rate = document.getElementById("daily_correct_rate")
  const daily_time = document.getElementById("daily_time")
  let current_daily_time = parseFloat(daily_time.value)
  const daily_average_time = document.getElementById("daily_average_time")
  const start_button = document.getElementById("start_button")
  const again_button = document.getElementById("again_button")
  const note = ["E3", "F3", "F#3", "G3", "G#3", "A3", "A#3", "B3", "C4", "C#4", "D4", "D#4"]
  const answers = document.querySelectorAll(".answer_button")
  const correct = document.getElementById("correct")
  const chime_correct = document.getElementById("chime_correct")
  const chime_wrong = document.getElementById("chime_wrong")
  const submit_buttons = document.querySelectorAll("#submit")

  again_button.style.display = "none"
  total_correct_rate.value = calc_rate(total_correct_count.value, total_wrong_count.value)
  daily_correct_rate.value = calc_rate(daily_correct_count.value, daily_wrong_count.value)
  if (parseInt(total_correct_count.value) == 0) {
    total_average_time.value = 0
  } else {
    total_average_time.value = Math.round(parseFloat(total_time.value) / parseInt(total_correct_count.value) * 100) / 100
  }
  if (parseInt(daily_correct_count.value) == 0) {
    daily_average_time.value = 0
  } else {
    daily_average_time.value = Math.round(parseFloat(daily_time.value) / parseInt(daily_correct_count.value) * 100) / 100
  }
  

  start_button.addEventListener("click", () => {
    const now = Tone.now()
    this.total_intervalID = setInterval(() => total_time.value = Math.round((current_total_time + Tone.now() - now) * 10) / 10, 10)
    this.daily_intervalID = setInterval(() => daily_time.value = Math.round((current_daily_time + Tone.now() - now) * 10) / 10, 10)

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
        total_correct_count.value = parseInt(total_correct_count.value) + 1
        total_correct_rate.value = calc_rate(total_correct_count.value, total_wrong_count.value)
        daily_correct_count.value = parseInt(daily_correct_count.value) + 1
        daily_correct_rate.value = calc_rate(daily_correct_count.value, daily_wrong_count.value)
        if (parseInt(total_correct_count.value) == 0) {
          total_average_time.value = 0
        } else {
          total_average_time.value = Math.round(parseFloat(total_time.value) / parseInt(total_correct_count.value) * 100) / 100
        }
        if (parseInt(daily_correct_count.value) == 0) {
          daily_average_time.value = 0
        } else {
          daily_average_time.value = Math.round(parseFloat(daily_time.value) / parseInt(daily_correct_count.value) * 100) / 100
        }
        chime_correct.play()
        if (submit_buttons != null) {
          submit_buttons.forEach((submit_button) => {
            submit_button.click()
          })
        }
        start_button.style.display = "inline"
        again_button.style.display = "none"
        answers.forEach((answer) => {
          answer.style.visibility = "hidden"
        })
        clearInterval(total_intervalID)
        current_total_time = parseInt(total_time.value)
        clearInterval(daily_intervalID)
        current_daily_time = parseInt(daily_time.value)
      } else {
        correct.innerHTML = '<p>Wrong!</p>'
        total_wrong_count.value = parseInt(total_wrong_count.value) + 1
        total_correct_rate.value = calc_rate(total_correct_count.value, total_wrong_count.value)
        daily_wrong_count.value = parseInt(daily_wrong_count.value) + 1
        daily_correct_rate.value = calc_rate(daily_correct_count.value, daily_wrong_count.value)
        chime_wrong.play()
        if (submit_buttons != null) {
          submit_buttons.forEach((submit_button) => {
            submit_button.click()
          })
        }
      }
    }
    answer.addEventListener("click", correct_or_wrong)
  })
}

if (document.URL.match(/quizes/)) {
  addEventListener("DOMContentLoaded", quiz)
}
