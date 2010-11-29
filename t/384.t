use strict;
use warnings;
use Test::More tests => 68;
use Digest::Luffa qw(luffa_384 luffa_384_hex);

my $len = 0;

while (my $line = <DATA>) {
    chomp $line;
    my ($msg, $digest) = split '\|', $line, 2;
    my $data = pack 'H*', $msg;
    $digest = lc $digest;

    if ($len and not $len % 8) {
        my $md = Digest::Luffa->new(384)->add($data)->hexdigest;
        is($md, $digest, "new/add/hexdigest: $len bits of $msg");
        is(
            luffa_384_hex($data), $digest,
            "luffa_384_hex: $len bits of $msg"
        );
        ok(
            luffa_384($data) eq pack('H*', $digest),
            "luffa_384: $len bits of $msg"
        );
    }

    my $md = Digest::Luffa->new(384)->add_bits($data, $len)->hexdigest;
    is($md, $digest, "new/add_bits/hexdigest: $len bits of $msg");
}
continue { $len++ }

__DATA__
00|117D3AD49024DFE2994F4E335C9B330B48C537A13A9B7FA465938E1A02FF862BCDF33838BC0F371B045D26952D3EA0C5
00|BEE5FEDBDDDBF6949FA03DD7F29143365914B62F170E0FE65D64307BA8397CADC1F09605D88751C98C71506F7929DF5C
C0|4F7D4C5D9D8FB5D7DD2EB40DF43BF803A89ABF01AFA035E5E74F656BC1BD82C68091CAC739E6922F1299B08174A52CD0
C0|BA881E6E7265397AF1A77F06109A79404DCC6215823B9831CCDF6C9AEC6EE3D10EAF736686431F9D55D5F7A36B0B712E
80|B37466AE7477CF16C9FAB2FF6C67B020462D9609A9A1CFD6CAF71B8D125BB21579CF06591FDDBD2B92C66E18B452C93E
48|97CEAB92E32F53986BBD13EED00901714B446E76D4D76A064C027B00023546F5DE5ADF3DE38C6449B3B016779D999E03
50|32660C81447BE4EDF037F1EF78B1790C4D40BDFFE9D54AA3572D922B62CC5D59036F817DD5E72EB4BCD58251461943D5
98|2FE8D5862B765E44B1962A9B9F9F0F6E1C285A72C96CED9629A9B905FC6E0DE1D9BA6E8603D6853164AF3A54EE5708A2
CC|E1979D16848976CA9FF183EC28998AB3D4B56942497F8E2C6D51895A96C7465DF6D7B66D6BA9636A16DBE51AAE6D2EB9
9800|80021FE117E24E5426A4F7C0855F3BD06993D82355AA440A8AE51054FDB288A4C485AD616B0B12B8810C9C284FBA3661
9D40|0F10A4A723A7D4FBEEB03CAF8AF8A7BB68ACB3B0F5AA7D1652CE6A181C2AEF05DA5AA8F48CEC06EDD6CE055E1311DFA8
AA80|4DD328DB65ADF70393DFA783A0CA4ADB7A6E8AB2D7AF1387ACF2C8BC3E2532ED0459B6B8B7535A8A9BFEC1E9825CE7E8
9830|E53C8956D4DCEF0C5A667D5BC827177EEDF56AE12F929E2514C76E92CF6EC5EC469255C9FEF5C1704489B75DEDD263ED
5030|5EFAA86346A3E826D718B4E460F96E43D296D6A58FC3D171ABC4FC02CA18D6D6F1CD73B0914A06FBC3D8A5C6F944513C
4D24|2E0AD72040E2E6C3F8DBF2FED27EBB13916658059C52E6104A87A7DEE09397F76F2C2AAB68E10335097D25FFE57D624C
CBDE|DADDA4A38EEF2144E35C0DC975D63193CAFD9FABB5D6959DFE2A0826A8D264F527329A0EB1CB635B1B20AC7553613EC2
41FB|836E9C8429D4A071935C72B0E575EA4CCA81642DC14A98A87307E02AC2D812682CE3EEAF8043330A7EA5CBE3A578B5D2
4FF400|91A753602FFB316908C67B190F57FBFD0D43075096B3FB1E360C6EF503DFB126085A756A78042B6CE9CC87CD3C1DA2CF
FD0440|56782E760EC9A9D2A9FB77FDF68B1287D4ABE5DD7EC2BC296849AB771EE3BF11C748028E7A5186A0E583450CEDB4A4AD
424D00|1314C0653D073748C2B673238AD2DC8C3D070A8788D62F2E2C5D50293107B05D39D58702F8922A98448AEE0EB609D520
3FDEE0|56379407B6D08FD7F43436F46DB5AA98F71E2935AC1C269F86C08649B4CBB34F27FFD6DCA2A3C11313BA86241EB5D774
335768|9EC1678CDBCE642568872A04D4D09A4B5CD8556B38E3E56C3D1BCBF90606BB84D957F7834401F2360D4CD380704C3493
051E7C|1F22C6D92D021FA10A5244B9A8314B4520D2C3113D134B1073D25076CECAD168902A84E1F67F97D2CC264F72B1B2C19C
717F8C|D2BD58326A72B409AC275F2949EA87BD244671BFD8B35E619B9A1C1F1A6210CAE04D740B63A6DC5AB357EE921BB70CD0
1F877C|0AFF61867C087908D2B9742012BB980CAE833C79FD4ECAAEA31BC1279F4CE356D6308C36D1FD0DBE70F652B0E2C66D35
EB35CF80|8EC339E65ED94EFD6353C0EC93AF874CA86650832393623967A68E759525D3CD4D01F6E79458AE406E7F64240351AC8E
B406C480|4281097FD34F3E7ED33E95D3B928E8D47069EC5929E10A9AFB8F96CE6DAE43ABAD85FE21013B59BBD3AAEE8783EF2B7A
CEE88040|422B7E24DE216EADEC5D543AA859C93327DA5C894FF620D6516B57715BF7D804711286F5D449253F19F78444569C1F0F
C584DB70|09808B1A7B66BE5343EB310DE507E85699F32EE9E537B050EACF5C815F265A68D304F9DC0099A3844620879D8F164339
53587BC8|5928CB9B8B370F24598890ED5BAF8B49E8556958A6133238E486FD595AF1B6DE288F42F338D0EF952E1BC30187E82DAC
69A305B0|ECBB84EBD828F70E1A1CE009BB972C5069245511831E11EFC83EBEFB4BED0B4AC46E36560CBA71538CCE0B6B3CD6836A
C9375ECE|F92CA1760798EED5C3C9922D447A5AC24E421A5B63332CF52DEB161FAA1DE8956D33F23FE56DC03E6D347681A8840CA9
C1ECFDFC|3736466CA7DC43A81025378E6CE678FE010EBB06382A73113AF39104CEA0F9BF00E27D12E0A1E7F37516E5CD0F2E9752
8D73E8A280|E23F103C0EB696A364A6D4A295F466C6C4895530E1A1569CFDE8387BF3E50F3D0E692CA76197FA3531ABEED2B6A75DEB
06F2522080|3CFF9FDA9070570A7F4F7D3D5B45D674CF8494B0FCA28E94F0CBD782E11201C69A17AD79EAE7EC818AAA7458DD21FD13
3EF6C36F20|84ABCA1A2D3B28E6870CCC92E9876F5CCD0D8E016C5D63D30BB601D7A082136BAEFB1562D3D837DBB6F254C8061A00D3
0127A1D340|EB00128553455ACAB5E93E5E55322ED1C6718499CAB5BE0F9119FF6E42BB8F6D8F7659A7A897222937FC81C09AA6EA70
6A6AB6C210|6EA6C9E9A3BB556067E1D46AE8A47C1E381E5A1DB36D7154AAFD872E49501218731D405C6AF36FA43CE101DE391F84EF
AF3175E160|E042556EB0839F735ED98BA25BB61353296DA908534BDC1CF57D41C6C2982D51CE0271CCE423327EDE9DACCC196A5B10
B66609ED86|1D804D190CF28C5EBE31348BFB91FC334C4C16D99BDD423672C9B3D72BBF62717FBAFA03E29EBEEE2B6E22E8ADCFA4A1
21F134AC57|FAC3B3788807C40CFE268F27534AADDBD85CA21444ADD77D96ACFC2B05F992143BE70A8EF21DB3AA6057974B5824F886
3DC2AADFFC80|26C91CA695C30C4E67BE812B374BF8D8122D995DE50C997B45B48A77840AC455A81BE79B29F8E5410367E133C8A71D3C
9202736D2240|B6AE2C87C0CA392737A54F47A7EA4F3CA65476736491FA5D88523B9BAFE84D804AAB645F304CA2409D2DE962CE656D8C
F219BD629820|E1F4A8091353699505CA8261965A447E65826BC555F5339BA04C2219468695F124B785EB1796B0593779351EE72E03FC
F3511EE2C4B0|73FD3DFE9032DE8DCD033722664C87D9D3982D3FF834BC693581863CFE551096EA260B02EFFE448E948E9AAE5E515534
3ECAB6BF7720|7A25AF0F7474FF660A379FD8D9DCE4EF9799D331C59986D506A8077928E1EED89D68D74D0B61324BE5E9FFE3B075FE3A
CD62F688F498|924F398A623EBFEA045B151447A12386E59495A14A58F9BB809BF7AEB50C96CE2744FD23812EC4BCD2C2121F0BB09800
C2CBAA33A9F8|B83BF976BE34CB6F8D785CB175E12DE95BA5F6DE3DEF4DEF4E01FE74E3C5CF4196D38835F7E883125EFD23A021DD92D0
C6F50BB74E29|5186E3872799F8FBCBFCCA6522A6C05E900386D543795DD288766DFF642DDD30F5DFE0A6D5A515AE0D86E6E0A66A4F58
79F1B4CCC62A00|24141A3457FEAD4D9FD6212415BC972FD6ECADBBE84A05311A2D63F13024E3EA6A9E4504052CE177FA41F4D89AAB10BF
