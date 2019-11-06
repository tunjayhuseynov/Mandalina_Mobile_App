@extends('layout.home')

@section('content')

<div class="container-fluid">
    <div class="row">
        <div class="col-3">
            <label>Select a series:</label>
            <select class="js-example-basic-single" style="width: 100%" name="type" required>
                <option disabled selected value="">Select a Type</option>
                @foreach ($data[0] as $item)

                <option value="{{$item->id}}">{{$item->name}}</option>

                @endforeach
            </select>

        </div>
        <div class="col-1">

        </div>

        <div class="col-8">
            <div class="list-group ">
                <div class="list-group-item active" style="background-color: #ff861f ">
                    Episodes: <div class="d-none addingLink" style="float:right;"><a id="addlink" href="/AdminPanelPinnme/newepisode">Add episode</a></div>
                </div>
                <div class="append">
                        <li class="list-group-item">No Series Selected</li>
                </div>

            </div>
        </div>
    </div>
</div>

<script>
    $('.js-example-basic-single').select2({
        width: 'resolve',
    });

    $('.js-example-basic-single').on('change', function(){
        $(".addingLink").removeClass("d-none")
        var id =$(this).val()
        $.getJSON( "{{$data[1]}}/AdminPanelPinnme/fetchepisodes/"+$(this).val(), function(data){
            var list = [];
           
           
            $("#addlink").attr("href", "/AdminPanelPinnme/addEpisode/"+id)
            
            $.each( data, function( key, val ) {
                
                list.push( '<li class="list-group-item">' + ++key +'. '+ val['name'] + '<div style="float: right">  <a href="'
                +link("episodeDetail", val['id'])+'">View</a> | <a href="'
                +link("episodeEdit", val['id'])
                +'">Edit</a>  | <a href="'+
                link("episodeDelete", val['id']) + '">Delete</a></div> </li>' )
                
         });
        
        $(".append").html(list.join(" "))

        })
    })

    var link = function(route, id){
            return "/AdminPanelPinnme/"+route+"/"+id
    }

</script>
@endsection