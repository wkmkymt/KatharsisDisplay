$(function(){
    //visitorListに客の情報を読み込めば動作する。
    var visitorList = []

    var person = {
        name: 'Bob',
        org: '京都大学総合人間学部',
        tag: ['創', '食'],
        msg: "メッセージだよ",
    };
    visitorList.push(person);
    var person = {
        name: 'Bob2',
        org: '株式会社スゴイコンサルティング',
        tag: ['人', '食'],
        msg: "メッセージだね〜",
    };
    visitorList.push(person);

    colorList =["blue", "purple"];
    $('.swiper-wrapper').empty();
    var i = 0;
    for (visitor of visitorList) {
        var slide = $(document.createElement('div'));
        $(slide).attr('class', 'swiper-slide')

        var section = $(document.createElement('section'));
        var color = colorList[i % colorList.length];
        $(section).attr('class', 'displayprof bg_'+ color)
        $(slide).append(section);

        var wrap = $(document.createElement('div'));
        $(wrap).attr('class', 'wrap');
        $(section).append(wrap)

        var post_profimg = $(document.createElement('div'));
        $(post_profimg).attr('class', 'post_profimg');
        $(wrap).append(post_profimg);

        var mainimgframe = $(document.createElement('div'));
        $(mainimgframe).attr('class', 'mainimgframe');
        $(post_profimg).append(mainimgframe);

        var pic = $(document.createElement('img'));    
        $(pic).attr('src','./img/prof3.jpg');
        $(mainimgframe).append(pic);

        var prof_body = $(document.createElement('div'));
        $(prof_body).attr('class', 'prof_body'); 
        $(wrap).append(prof_body);

        var under = $(document.createElement('div'));
        $(under).attr('class', 'under');
        $(prof_body).append(under);

        var prof_name = $(document.createElement('h1'));
        prof_name.html(visitor.name);
        $(under).append(prof_name);

        var prof_org = $(document.createElement('h2'));
        prof_org.html(visitor.org);
        $(prof_body).append(prof_org);

        var prof_tag = $(document.createElement('h2'));
        var temp = "";
        for(eachtag of visitor.tag) {
            temp+="#" + eachtag + " ";
        }
        prof_tag.html(temp);
        $(prof_body).append(prof_tag);

        var clearfix = $(document.createElement('div'));
        $(clearfix).attr('class', 'clearfix');
        $(wrap).append(clearfix);

        var prof_msg = $(document.createElement('div'));
        $(prof_msg).attr('class', 'prof_msg');
        $(wrap).append(prof_msg);

        var prof_msg_p = $(document.createElement('p'));
        prof_msg_p.html("&quot;" + visitor.msg + "&quot;");
        $(prof_msg).append(prof_msg_p);

        $('.swiper-wrapper').append(slide);
        i++;
    }

    //要素生成後に下記を処理
    var swiper = new Swiper('.swiper-container', {
        loop: true,
        autoplay: {
          delay: 2000,
          disableOnInteraction: false
        },
        speed: 800,
        slidesPerView: 1,
        spaceBetween: 0,
      });
});