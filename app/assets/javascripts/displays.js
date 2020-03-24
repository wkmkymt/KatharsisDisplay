let swiper = new Swiper('.swiper-container', {
  loop: true,
  autoplay: {
    delay: 2000,
    disableOnInteraction: false
  },
  speed: 800,
  slidesPerView: 1,
  spaceBetween: 0,
})

let addProf = (user, tags) => {
  let slide = $(document.createElement('div'))
  $(slide).attr('class', 'prof_' + user.id + ' swiper-slide')

  let section = $(document.createElement('section'))
  // let color = colorList[i % colorList.length]
  // $(section).attr('class', 'displayprof bg_' + color)
  $(section).attr('class', 'displayprof bg_blue')
  $(slide).append(section)

  let wrap = $(document.createElement('div'))
  $(wrap).attr('class', 'wrap')
  $(section).append(wrap)

  let post_profimg = $(document.createElement('div'))
  $(post_profimg).attr('class', 'post_profimg')
  $(wrap).append(post_profimg)

  let mainimgframe = $(document.createElement('div'))
  $(mainimgframe).attr('class', 'mainimgframe')
  $(post_profimg).append(mainimgframe)

  let pic = $(document.createElement('img'))
  // $(pic).attr('src', './img/prof3.jpg')
  $(mainimgframe).append(pic)

  let prof_body = $(document.createElement('div'))
  $(prof_body).attr('class', 'prof_body')
  $(wrap).append(prof_body)

  let under = $(document.createElement('div'))
  $(under).attr('class', 'under')
  $(prof_body).append(under)

  let prof_name = $(document.createElement('h1'))
  prof_name.html(user.name)
  $(under).append(prof_name)

  let prof_org = $(document.createElement('h2'))
  prof_org.html(user.organization)
  $(prof_body).append(prof_org)

  let prof_tag = $(document.createElement('h2'))
  let temp = ""
  for (tag of tags) {
    temp += "#" + tag.name + " "
  }
  prof_tag.html(temp)
  $(prof_body).append(prof_tag)

  let clearfix = $(document.createElement('div'))
  $(clearfix).attr('class', 'clearfix')
  $(wrap).append(clearfix)

  let prof_msg = $(document.createElement('div'))
  $(prof_msg).attr('class', 'prof_msg')
  $(wrap).append(prof_msg)

  let prof_msg_p = $(document.createElement('p'))
  let msg = user.comment ? user.comment : ''
  prof_msg_p.html("&quot;" + msg + "&quot;")
  $(prof_msg).append(prof_msg_p)

  swiper.appendSlide(slide)
}

let removeProf = (id) => {
  let index = $('.prof_' + id).attr('data-swiper-slide-index')
  swiper.removeSlide(index)
}