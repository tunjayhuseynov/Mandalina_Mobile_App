@extends('layout.home')
@section('content')
@inject('type', 'App\Providers\DataManupilation')

<div class="container-fluid">
        <div class="row">
                <div class="col-3">
                        <div class="box text-center" style="padding: 0!important">
                                <label>Cover Image: </label> <br>
                                <img style="max-width: 100%" src="{{$data[3].$data[2]['image']}}">
                        </div>
                        <div class="box text-center" style="padding: 0!important">
                                <label>Poster Image: </label> <br>
                                <img style="max-width: 100%" src="{{$data[3].$data[2]['poster']}}">
                        </div>
                </div>

                <div class="col-3">
                        <div class="box text-center">
                                <label>Name: </label>
                                <h4>{{$data[2]['name']}}</h4>
                        </div>
                        <div class="box text-center">
                                <label>Tag: </label>
                                <h4>{{$data[2]['tagName']}}</h4>
                        </div>
                        <div class="box text-center">
                                <label>Type: </label>
                                <h4>{{$data[2]['movieType']==DataManupilation::Movie?"Movie":"Series"}}</h4>
                        </div>
                        <div class="box text-center">
                                <label>Year: </label>
                                <h4>{{$data[2]['year']}}</h4>
                        </div>
                        <div class="box text-center">
                                <label>Addition Date: </label>
                                <h4>{{$data[2]['addedDate']}}</h4>
                        </div>
                        <div class="box text-center">
                                <label>Age Limit: </label>
                                <h4>{{$data[2]['rate']}}</h4>
                        </div>
                        <div class="box text-center">
                                <label>IMDB: </label>
                                <h4>{{$data[2]['imdb']}}</h4>
                        </div>
                        <div class="box text-center">
                                <label>{{$data[2]['movieType']==1?"Duration: ":"# of Episodes"}} </label>
                                <h4>{{$data[2]['movieType']==1?$data[2]['length'].' mins':count($data[2]['episodes'])}}
                                </h4>
                        </div>
                </div>
                <div class="col-6">
                        <div class="box text-center" style="padding: 15px 15px;">
                                <label>Description: </label>
                                <h5 style="text-align: justify">{{{$data[2]['description']}}}</h5>
                        </div>
                        @if($data[2]['movieType']==DataManupilation::Movie)
                        <div class="box text-center" style="padding: 15px 15px;">
                                <label>Movie Link: </label>
                                <h5 style="text-align: center">
                                        <a target="_blank"
                                                href="{{{$data[2]['movieLink']}}}">{{{$data[2]['movieLink']}}}</a>
                                </h5>
                        </div>
                        <div class="box text-center" style="padding: 15px 15px;">
                                <label>English Link: </label>
                                <h5 style="text-align: center">
                                        <a target="_blank"
                                                href="{{{$data[2]['movieLink']}}}">{{{$data[2]['englishLink']}}}</a>
                                </h5>
                        </div>
                        @endif
                        <div class="box text-center" style="padding: 15px 15px;">
                                <label>Trailer Link: </label>
                                @if($data[2]['trailerLink'] != null)
                                <h5 style="text-align: center">
                                        <a target="_blank"
                                                href="{{{$data[3].$data[2]['trailerLink']}}}">{{{$data[3].$data[2]['trailerLink']}}}</a>
                                </h5>

                                @else
                                <h5 style="text-align: center">
                                        No Trailer
                                </h5>
                                @endif
                        </div>
                </div>
        </div>
</div>

@endsection