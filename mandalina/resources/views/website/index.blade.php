<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <script src="https://unpkg.com/vuex"></script>
</head>

<body>


    <div id="vapp">
        <box></box>
    </div>


    <script src="{{asset('assets/js/test.js')}}"></script>
    <script>

        const vueApp = new Vue({
            el: '#vapp',
            data: {
                display: 'redbox'
            },
        })

    </script>
</body>

</html>
