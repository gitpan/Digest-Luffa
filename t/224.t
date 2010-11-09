use strict;
use warnings;
use Test::More tests => 19;
use Digest::Luffa qw(luffa_224 luffa_224_hex);

my $len = 0;

while (my $line = <DATA>) {
    chomp $line;
    my ($msg, $digest) = split '\|', $line, 2;
    my $data = pack 'H*', $msg;
    $digest = lc $digest;

    if ($len and not $len % 8) {
        my $md = Digest::Luffa->new(224)->add($data)->hexdigest;
        is($md, $digest, "new/add/hexdigest: $len bits of $msg");
        is(
            luffa_224_hex($data), $digest,
            "luffa_224_hex: $len bits of $msg"
        );
        ok(
            luffa_224($data) eq pack('H*', $digest),
            "luffa_224: $len bits of $msg"
        );
    }
    else {
        TODO:
        eval {
            local $TODO = 'add_bits is not yet implemented';
            my $md = Digest::Luffa->new(224)->add_bits($data, $len)
                ->hexdigest;
            is($md, $digest, "new/add_bits/hexdigest: $msg");
        };
    }
}
continue { $len++ }

__DATA__
00|DBB8665871F4154D3E4396AEFBBA417CB7837DD683C332BA6BE87E02
00|14B20CB4CC4C4BE3D472262F69F43AA87BBDE60F42DB8ABE6A39C2B1
C0|802D5029CE7126AD1730C81FDEA2CEBD12493EEEB3F0ABBF543570C9
C0|61F1BC3B35AE84470ED19A2F7F6DBFCA72C0BEDA503A60F58153BA02
80|A6DB3F8B814FD182320B6E04BD0913C3914E2FF21E39AA5ADC0182E6
48|5D6510CE8FCF6CFB9C00EDBAD7A1D03EA7F9459919A38D50D349A6D3
50|29036D8B14F75A1E98DBB66CE00C6F52798CB2DDFB5821E26C06A9C1
98|4E52F96D0FF6225C07699F8B1DD4C77AD23B5B9DBE749B9D1091FD83
CC|E47D4158BFE03555D370D8FD877EAD17D6AA9FDC689A9614C411FBBA
9800|6A88CB7B4D67B5622566D72FDC9EE4F084DC1CEDF20D5A19FC6A4755
9D40|FE2E6A5D3A2407F4BF927BCFD1552AA1E627C9D0B3DD2D32F7F5394F
AA80|468BCD67B17C324329C77BBF6B7C8B7B1919199379AF96FB75F44029
9830|05A7043327E28B2C08152C24C1FB5061A7F75B51853A396C8BAF14AD
5030|5E278CB8993E2177A77EB5ADBB15A6E596FB2D9A398F48500F621434
4D24|3AA4F2CD7A7C3EE8A9C505DA4699B156AECB10FC3E1E19751ED368F8
CBDE|FBD488C332F2B4ED7CDCC664E545371AE4ADCEDDEEE9210584545F8C
41FB|08CBDD1C9CAEA9711AB2B30B872DDC09F2954B98AC1850ABE3F648F1
4FF400|2F6C78557B2CB3E055934C0FCD89AD6A5D0CC973FA51B5CF793D6F94
FD0440|FC8DA3D22A2C144602E848CE0D2B288F7B09944D5A734803D0D3A07E
424D00|B49F463E44DA152256A55FAD516B6E44614239224437D9E5E96D0012
3FDEE0|F303A96035904EE1FEAB4DCEB3246BE6CF390F0129E561AA35DD6758
335768|021E39520112E1F4C7C84E369BD4BCAAD71A34DBF9D51A643BCE2793
051E7C|82C3CCDB21CA5B18EDF81A7288ABBBD0430D69268C41EFDE63F116FC
717F8C|2329E93E21678147AF60F8AD43E041F58BC767FE9AC54C8F9D0BD9EC
1F877C|A590D4995C909ABD9150398D4AB9465A8E9F768C576921C26A998857
EB35CF80|3CA121A117AD21E0925966D4537A3FFDE141AADB545432DE09BBE232
B406C480|C3B4443E0CAB6D4E2D2B687E9A6B0C0B739B34D5F3B2602E9B12F7E8
CEE88040|D2C0B73F444850DCC2985C759F435F513DCF20AED9DEAF94CFF4C83F
C584DB70|C64217EAD0A8D70214D927B0341E384538F6C940E5817D1F2AFAF709
53587BC8|4D2105AAC428D5D4DBEFB7BD583B0699ACDB25B758616114EF7BCE5C
69A305B0|798E2E6D7DE531C4EDC2CD461A13AF3AA5EF6C557FE5EFE460C12D12
C9375ECE|453901372FEA0F6BF451D8D90835FB3411A2C8F5DAD6C3DE662EB22F
C1ECFDFC|25C82F898F66355ABA7A6215D07CAB27FBEEEDD16B52AA910040B40F
8D73E8A280|825A55B5A847EF13E8434E4C88FBD51331282F25F5535A0F887658E7
06F2522080|908F60E34E534348D4C44A06879AA63022A4B869C7558BF6EF03150C
3EF6C36F20|5C3C54B4A5EB778DEA3BB7516C8E1D20BEE691DABF9CB466FF036FC2
0127A1D340|4C25FF93B3C5D2EE55A08C36FA32AC180545A2E67FD43DDC851112BA
6A6AB6C210|AF65196C427465CAE7FD93D309F361C5F05FF3F3C7EAA2EE8C5B15F7
AF3175E160|C76FCA861F8A5F1A24123FF3E875AB0A1C099B97ADA91E13E781BBE2
B66609ED86|ED12EFCB066EACD5E5FD88DA515706F3FE3CC8B352DC64E5A0749115
21F134AC57|C3C9B051075CA4DA37DD0A43136E1E6566CB147371325E1DBEFEFB8A
3DC2AADFFC80|7176BBC7742F3B731929436663A5CBAB13F10FBE7CB4C455DDE6FF73
9202736D2240|F39E24C85FF1E9F2D4C2F822B537B2511B7FF38A7FA93F43891001B0
F219BD629820|4EAAB39EBF8ED3D9F0D6B79768083A766D348582A0224FF5DB9C7F34
F3511EE2C4B0|543E81D1A5CDE93B584CD308511FCDFD240B31BE375A8D02C13AF2B2
3ECAB6BF7720|60140F97D0921582D213DE2409EA239EB474FC6E774C6F6916550093
CD62F688F498|94A75D1388A5629CE0720D70290EB06CBF2693898C2526FE8ED8E460
C2CBAA33A9F8|0475E3898C8CFDFFF0221061D87A49A24E867780C55150009EA05AE1
C6F50BB74E29|81DDB86C64F4A06160121ED6E8A4A50C6144CDF27F5CD0CA85C197D9
79F1B4CCC62A00|B74AF4F865E800E48CD066A4FBF427E5E691E4BA80F7A50A0CCD94CF