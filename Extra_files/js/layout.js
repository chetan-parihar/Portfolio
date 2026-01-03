    (function () {
      "use strict";

      const mobileNavToggle = document.querySelector('.mobile-nav-toggle-fix');

      if (mobileNavToggle) {
        mobileNavToggle.addEventListener('click', function (e) {
          document.body.classList.toggle('mobile-nav-active');
          this.classList.toggle('bi-list');
          this.classList.toggle('bi-x');
        });
      }

      document.addEventListener('click', function (e) {
        if (document.body.classList.contains('mobile-nav-active')) {
          const header = document.querySelector('#header');
          const toggle = document.querySelector('.mobile-nav-toggle-fix');

          if (!header.contains(e.target) && !toggle.contains(e.target)) {
            document.body.classList.remove('mobile-nav-active');
            toggle.classList.remove('bi-x');
            toggle.classList.add('bi-list');
          }
        }
      });

      const backToTop = document.querySelector('.back-to-top');
      if (backToTop) {
        const toggleBacktotop = () => {
          if (window.scrollY > 100) {
            backToTop.classList.add('active')
          } else {
            backToTop.classList.remove('active')
          }
        }
        window.addEventListener('load', toggleBacktotop);
        document.addEventListener('scroll', toggleBacktotop);
      }
    })();


    (function() {
      "use strict";
      
      const mobileNavToggle = document.querySelector('.mobile-nav-toggle-fix');
      
      if (mobileNavToggle) {
        mobileNavToggle.addEventListener('click', function(e) {
            document.body.classList.toggle('mobile-nav-active');
            this.classList.toggle('bi-list');
            this.classList.toggle('bi-x');
        });
      }

      document.addEventListener('click', function(e) {
          if (document.body.classList.contains('mobile-nav-active')) {
              const header = document.querySelector('#header');
              const toggle = document.querySelector('.mobile-nav-toggle-fix');
              
              if (!header.contains(e.target) && !toggle.contains(e.target)) {
                  document.body.classList.remove('mobile-nav-active');
                  toggle.classList.remove('bi-x');
                  toggle.classList.add('bi-list');
              }
          }
      });
      
      const backToTop = document.querySelector('.back-to-top');
      if (backToTop) {
        const toggleBacktotop = () => {
          if (window.scrollY > 100) {
            backToTop.classList.add('active')
          } else {
            backToTop.classList.remove('active')
          }
        }
        window.addEventListener('load', toggleBacktotop);
        document.addEventListener('scroll', toggleBacktotop);
      }
    })();


    (function() {
      "use strict";
      
      const mobileNavToggle = document.querySelector('.mobile-nav-toggle-fix');
      
      if (mobileNavToggle) {
        mobileNavToggle.addEventListener('click', function(e) {
            document.body.classList.toggle('mobile-nav-active');
            this.classList.toggle('bi-list');
            this.classList.toggle('bi-x');
        });
      }

      document.addEventListener('click', function(e) {
          if (document.body.classList.contains('mobile-nav-active')) {
              const header = document.querySelector('#header');
              const toggle = document.querySelector('.mobile-nav-toggle-fix');
              
              if (!header.contains(e.target) && !toggle.contains(e.target)) {
                  document.body.classList.remove('mobile-nav-active');
                  toggle.classList.remove('bi-x');
                  toggle.classList.add('bi-list');
              }
          }
      });
      
      const backToTop = document.querySelector('.back-to-top');
      if (backToTop) {
        const toggleBacktotop = () => {
          if (window.scrollY > 100) {
            backToTop.classList.add('active')
          } else {
            backToTop.classList.remove('active')
          }
        }
        window.addEventListener('load', toggleBacktotop);
        document.addEventListener('scroll', toggleBacktotop);
      }
    })();
  