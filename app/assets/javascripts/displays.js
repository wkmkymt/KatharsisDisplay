let initSwiperSlides = () => {
  $('.swiper-slide')
    .not('.swiper-slide-duplicate')
    .each((index, slide) => {
      if ($(slide).hasClass('prof_user')) {
        userSlides.push({
          type: 'user',
          body: {
            id: slide.id.replace('prof_user_', ''),
            name: $(slide).find('.prof_name').text(),
            organization: $(slide).find('.prof_org').text(),
            comment: $(slide).find('.prof_msg p').text(),
            color: $(slide)
              .find('.displayprof')
              .attr('class')
              .replace('displayprof bg_', ''),
            tags: $(slide)
              .find('.prof_tag')
              .text()
              .replace(/\r?\n|&nbsp;| /g, '')
              .split('#')
              .slice(1),
          },
        })
      } else if ($(slide).hasClass('prof_ad')) {
        adSlides.push({
          type: 'ad',
          body: {
            id: slide.id.replace('prof_ad_', ''),
            sponsor: $(slide)
              .find('.sponsor')
              .text()
              .replace('Sponsored by ', ''),
            url: $(slide).find('.ad_qrcode').attr('src'),
          },
        })
      }
    })
}

let setChangeFlag = () => {
  changeFlag = true
}

let addUser = (user) => {
  userSlides.push(user)
}

let removeUser = (user) => {
  let target
  userSlides.forEach((slide, index) => {
    if (slide.body.id == user.id) target = index
  })
  userSlides.splice(target, 1)
}

let updateSlide = () => {
  if (userSlides.length || adSlides.length) {
    if (userSlides.length >= adSlides.length)
      swiperSlides = getOrderedSlides(userSlides, adSlides)
    else swiperSlides = getOrderedSlides(adSlides, userSlides)
  } else {
    swiperSlides = userSlides.concat(adSlides)
  }

  swiper.removeAllSlides()
  swiperSlides.forEach((slide) => {
    if (slide.type == 'user') addUserSlide(slide.body)
    else addAdSlide(slide.body)
  })
  swiper.update(true)
}

let getOrderedSlides = (bases, items) => {
  let slides = bases.slice()
  let step = Math.floor(bases.length / items.length)

  items.forEach((item, index) => {
    slides.splice(step * (index + 1) + index, 0, item)
  })
  return slides
}

let addUserSlide = (user) => {
  let slide = $(document.createElement('div'))
  $(slide).attr('id', 'prof_user_' + user.id)
  $(slide).addClass('swiper-slide prof_user')

  let section = $(document.createElement('section'))
  $(section).addClass('displayprof bg_' + user.color)
  $(slide).append(section)

  let wrap = $(document.createElement('div'))
  $(wrap).addClass('wrap')
  $(section).append(wrap)

  let post_profimg = $(document.createElement('div'))
  $(post_profimg).addClass('post_profimg')
  $(wrap).append(post_profimg)

  let mainimgframe = $(document.createElement('div'))
  $(mainimgframe).addClass('mainimgframe')
  $(post_profimg).append(mainimgframe)

  let pic = $(document.createElement('img'))
  $(pic).attr('src', '/users/' + user.id + '/image')
  $(mainimgframe).append(pic)

  let prof_body = $(document.createElement('div'))
  $(prof_body).addClass('prof_body')
  $(wrap).append(prof_body)

  let under = $(document.createElement('div'))
  $(under).addClass('under')
  $(prof_body).append(under)

  let prof_name = $(document.createElement('h1'))
  $(prof_name).html(user.name)
  $(prof_name).addClass('prof_name')
  $(under).append(prof_name)

  let prof_org = $(document.createElement('h2'))
  $(prof_org).html(user.organization)
  $(prof_org).addClass('prof_org')
  $(prof_body).append(prof_org)

  let prof_tag_div = $(document.createElement('div'))
  $(prof_tag_div).addClass('multiline-text-container')

  let prof_tag = $(document.createElement('h2'))
  let temp = ''
  for (tag of user.tags) {
    temp += '#' + tag + ' '
  }
  $(prof_tag).html(temp)
  $(prof_tag).addClass('prof_tag')
  $(prof_tag).addClass('multiline-text')
  $(prof_tag_div).append(prof_tag)
  $(prof_body).append(prof_tag_div)

  let clearfix = $(document.createElement('div'))
  $(clearfix).addClass('clearfix')
  $(wrap).append(clearfix)

  let prof_msg = $(document.createElement('div'))
  $(prof_msg).addClass('prof_msg')
  $(prof_msg).addClass('multiline-text-container')
  $(wrap).append(prof_msg)

  let prof_msg_p = $(document.createElement('p'))
   $(prof_msg_p).addClass('prof_msg_body')
  $(prof_msg_p).addClass('multiline-text-3')
  let msg = user.comment ? user.comment: ''
  $(prof_msg_p).html(msg)
  if (user.comment) {$(prof_msg).append(prof_msg_p)}

  swiper.appendSlide(slide)
}

let addAdSlide = (ad) => {
  let slide = $(document.createElement('div'))
  $(slide).attr('id', 'prof_ad_' + ad.id)
  $(slide).addClass('swiper-slide prof_ad')

  let section = $(document.createElement('section'))
  $(section).addClass('displayprof bg_black')
  $(section).css('background-image', 'url(/advertisements/' + ad.id + '/image')
  $(slide).append(section)

  let sponsor_info_area = $(document.createElement('div'))
  $(sponsor_info_area).addClass('sponsor_info_area')
  $(section).append(sponsor_info_area)

  let sponsor = $(document.createElement('h1'))
  $(sponsor).html('Sponsored by ' + ad.sponsor)
  $(sponsor).addClass('sponsor')
  $(sponsor_info_area).append(sponsor)

  if (ad.url) {
    let ad_qrcode_area = $(document.createElement('div'))
    $(ad_qrcode_area).addClass("ad_qrcode_area")
    $(sponsor_info_area).append(ad_qrcode_area)

    let adimg = $(document.createElement('img'))
    $(adimg).attr('src', ad.url)
    $(adimg).addClass('ad_qrcode')
    $(ad_qrcode_area).append(adimg)
  }

  swiper.appendSlide(slide)
}

// ==================================================
//   Main
// ==================================================

let changeFlag = false
let userSlides = []
let adSlides = []
let swiperSlides = []

let swiper = new Swiper('.swiper-container', {
  loop: true,
  autoplay: {
    delay: 8000,
    disableOnInteraction: false,
  },
  speed: 800,
  slidesPerView: 1,
  spaceBetween: 0,
  on: {
    fromEdge: () => {
      if (changeFlag) {
        changeFlag = false
        updateSlide()
      }
    },
  },
})

initSwiperSlides()
