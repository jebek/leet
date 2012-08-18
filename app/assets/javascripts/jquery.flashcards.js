(function($){
	
	$.fn.jquizzy = function(settings) {
		
	var defaults = {
		socialStatus: 'I scored {score}% on this awesome test! Check it out!',
		startText : 'Let\'s get started!',
		endText: 'Finished!',
		splashImage: 'img/start.png',
		shortURL: null,
		answers: null,
		answer_choices: null,
		correct_answers: null,
		sendResultsURL: null,
		resultComments :  
	  {
		    perfect: 'Perfect!',
			 excellent: 'Excellent!',
			 good: 'Good!',
			 average: 'Acceptable!',
			 bad: 'Disappointing!',
			 poor: 'Not Good!',
			 worst: 'Real Shitty!'
	  }

           };  
		     
    var config = $.extend(defaults, settings);  
    var superContainer = $(this);

    var progress = superContainer.find('.progress'),
    progressKeeper = superContainer.find('.progress-keeper'),
		isAnimating = false,
    notice = superContainer.find('.notice'),
    progressWidth = progressKeeper.width(),
    userAnswers = [],
    questionLength = config.questions.length,
    slidesList = superContainer.find('.slide-container');
		
    function checkAnswers() {
        var resultArr = [],
        flag = false;
        for (i = 0; i < config.correct_answers.length; i++) {

            if (config.correct_answers[i] == userAnswers[i]) {
                flag = true;
            } else {
                flag = false;
            }
            resultArr.push(flag);
        }
        return resultArr;
    };

    function roundReloaded(num, dec) {
        var result = Math.round(num * Math.pow(10, dec)) / Math.pow(10, dec);
        return result;
    };

    function judgeSkills(score) {
        var returnString;
        if (score == 100)
            return config.resultComments.perfect;
else if (score > 90)
            return config.resultComments.excellent;
else if (score > 70)
            return config.resultComments.good;
else if (score > 50)
            return config.resultComments.average;
else if (score > 35)
            return config.resultComments.bad;
else if (score > 20)
            return config.resultComments.poor;
else
            return config.resultComments.worst;
    };

    progressKeeper.hide();
    notice.hide();
    slidesList.hide().first().fadeIn(500);

		  $(document).keydown(function (e) {
			if(isAnimating) {
				return false;
			}
      var keyCode = e.keyCode || e.which,
          choice = {first: 74, second: 75, third: 76, fourth: 186 }, $status = $('#status');

      switch (keyCode) {
				
        case choice.first:
					isAnimating = true;
          next_q(0);
        break;

        case choice.second:
					isAnimating = true;
          next_q(1);
        break;

        case choice.third:
					isAnimating = true;
          next_q(2);
        break;

        case choice.fourth:
					isAnimating = true;
          next_q(3);
        break;
      }
    });

	  function next_q(direction) {
				var num_q = Math.round(progress.width()/(Math.round(progressWidth / questionLength)));
        var thisLi = superContainer.find('ul.answers:eq(' + num_q + ') li:eq(' + direction + ')');

        thisLi.parents('.answers').children('li').removeClass('selected');
        thisLi.addClass('selected');

				thisLi.click();
    };

    superContainer.find('.nav-start').click(function() {

        $(this).parents('.slide-container').fadeOut(500, function() {
            $(this).next().fadeIn(500);
            progressKeeper.fadeIn(500);
        });
        return false;

    });

    superContainer.find('li').click(function() {
	 			isAnimating = true;
				$this = $(this);
				$this.parents('.answers').children('li').removeClass('selected');
        $this.addClass('selected');
        if ($this.parents('.slide-container').find('li.selected').length === 0) {
            notice.fadeIn(300);
            return false;
        }

        notice.hide();
        $this.parents('.slide-container').fadeOut(500, function() {
            $(this).next().fadeIn(500, function() {
							isAnimating = false;
});
        });
        progress.animate({
            width: progress.width() + Math.round(progressWidth / questionLength)
            }, 500);
        return false;
				q_num++;
    });

    superContainer.find('ul.answers:last li').click(function() {
        if ($(this).parents('.slide-container').find('li.selected').length === 0) {
            notice.fadeIn(300);
            return false;
        }
				
        superContainer.find('li.selected').each(function(index) {
            userAnswers.push($(this).parents('.answers').children('li').index($(this).parents('.answers').find('li.selected')));
        });

        progressKeeper.hide();
        var results = checkAnswers(),
        resultSet = '',
        trueCount = 0,
		  	shareButton = '',
        score,
		  	url;
		  
		  if (config.shortURL === null)  {config.shortURL = window.location};
		  
        for (var i = 0, toLoopTill = results.length; i < toLoopTill; i++) {
            if (results[i] === true) {
                trueCount++;
                isCorrect = true;
            }
            resultSet += '<div class="result-row"> Question #' + (i + 1) + (results[i] === true ? "<div class='correct'><span>Correct</span></div>": "<div class='wrong'><span>Incorrect</span></div>");
            resultSet += '<div class="resultsview-qhover">' + config.questions[i];
            resultSet += "<ul>";
            for (answersIteratorIndex = 0; answersIteratorIndex < config.answer_choices[0].length; answersIteratorIndex++) {
                var classestoAdd = '';
                if (config.answer_choices[i][answersIteratorIndex] == config.answers[i]) {
                    classestoAdd += 'right';
                }
					 if (userAnswers[i] == config.answer_choices[i][answersIteratorIndex]) {
                    classestoAdd += ' selected';
                }
                resultSet += '<li class="' + classestoAdd + '">' + config.answer_choices[i][answersIteratorIndex] + '</li>';
            }
            resultSet += '</ul></div></div>';

        }
        score = roundReloaded(trueCount / questionLength * 100, 2);

        resultSet = '<h2 class="qTitle">' + judgeSkills(score) + ' You scored ' + score + '%</h2>' + shareButton+ resultSet + '<div class="jquizzy-clear"></div>';
        superContainer.find('.result-keeper').html(resultSet).show(500);
        superContainer.find('.resultsview-qhover').hide();
        superContainer.find('.result-row').hover(function() {
            $(this).find('.resultsview-qhover').show();
            }, function() {
            $(this).find('.resultsview-qhover').hide();
            });
        $(this).parents('.slide-container').fadeOut(500, function() {
            $(this).next().fadeIn(500);
        });
        return false;
    });
	};
})(jQuery);