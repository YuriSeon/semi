$(function () {
    // 종료시간 조건 이벤트
    $("#timer").on("change", function () {
        let now = new Date();
        let nowTime = Number(now.getHours()) * 60 + Number(now.getMinutes()); // 분단위로 계산
        let end = $(this).val().split(":");
        let endTime = Number(end[0]) * 60 + Number(end[1]);
        console.log("now" + nowTime);
        console.log("end" + endTime);
        if (nowTime > endTime - 30) {
            $("#timer").val("");
            alert("현재 시간으로 부터 30분이후로 설정이 가능합니다.");
        }
    });

    // 이미지 파일 조건 이벤트 (미리보기)
    $("#togetherImg").on("change", e => readImg(e.target));
    function readImg(e) {
        const reader = new FileReader();
        reader.onload = e => { $("#miriImg").attr("src", e.target.result).css("width", "200px").css("height", "200px").css("display", "block"); }
        try {
            reader.readAsDataURL(e.files[0])
        } catch (err) {
            alert("이미지가 없습니다.")
            $("#miriImg").attr("src", "").css("display", "none");
        }
    }

    // 모집 인원 조건 이벤트
    $("input[name=person]").on("focusout", function() {
        if ($(this).val() < 1) {
            alert("모집인원의 최소는 1명입니다.");
            $(this).val("");
            return;
        }
        let personNum = $(this).val() + "명";
        $(this).attr("type", "text").val(personNum);
    });

    $("input[name=person]").on("focusin", function() {
        let num = $(this).val().substring(0, $(this).val().length - 1); // 저장 해두기 위해
        $(this).attr("type", "number").val(num);

    });


    // 지도 관련 이벤트
    document.getElementById("mainAddress").addEventListener("click", ()=> {
        // 지도 오픈
        new daum.Postcode(
            {
                oncomplete: (data) => { // 주소 선택시 자동으로 입력
                    var dongaddress = ""; // 모두 지번으로 받을꺼다.
                    if (data.autoJibunAddress == "") {
                        dongaddress = data.jibunAddress;
                    } else {
                        dongaddress = data.autoJibunAddress;
                    }
                    $("#mainAddress").val(data.address);
                    $("#maptr").css("display", "block");
                    $("input[name=subAddress]").focus();
                }
            }).open();
    })

    $("#mainAddress").on("keyup",()=>{
    	new daum.Postcode(
                {
                    oncomplete: (data) => { //선택시 입력값 세팅
                        var dongaddress = ""; // 모두 지번으로 받을꺼다.
                        if (data.autoJibunAddress == "") {
                            dongaddress = data.jibunAddress;
                        } else {
                            dongaddress = data.autoJibunAddress;
                        }
                        $("#mainAddress").val(data.address);
                        $("#maptr").css("display", "block");
                        $("input[name=subAddress]").focus();
                    }
                }).open()
    })


    $("input[name=subAddress]").on("focusin", () => {
    	var mapContainer = document.getElementById('map'),// 지도를 표시할 div 
            mapOption = {
                center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };
        // 지도를 생성합니다    
        var map = new kakao.maps.Map(mapContainer, mapOption);
        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();
        // 주소로 좌표를 검색합니다
        var pickAddress = $("#mainAddress").val();
        geocoder.addressSearch(pickAddress, function (result, status) {
            // 정상적으로 검색이 완료됐으면 
            if (status === kakao.maps.services.Status.OK) {
                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                // 결과값으로 받은 위치를 마커로 표시합니다
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });
                // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                map.setCenter(coords);
            }
        });
    });

});