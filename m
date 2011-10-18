Return-Path: <tonyputi@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201110181810.41338.lindner_marek@yahoo.de>
References: <CAFevQmMBoHLeQOhvYv9bYWh0YS7WYXDyL=geH9EcsqqgVeBj+w@mail.gmail.com>
	<201110181810.41338.lindner_marek@yahoo.de>
From: Filippo Sallemi <tonyputi@gmail.com>
Date: Tue, 18 Oct 2011 19:36:05 +0200
Message-ID: <CAFevQmNi+csqs5q-LQBMhpnZG9KS2Q0kZJYUgHd9jwrzZGbmjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Compile error on openwrt with new patch
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

No my patch folder was empty before update. Now the only way to
compile batman-adv is to revert to last version.

N.B. Here the command executed after first time error

1. svn clean;
2. svn distclean;
3. make -j 3

So I build a vergin openwrt with only batman-adv module but the error persi=
st.


2011/10/18 Marek Lindner <lindner_marek@yahoo.de>:
>
> Hi,
>
>> after an ./script/feeds update when i try to build openwrt I get an
>> error on batman-adv package:
>>
>> Applying
>> ./patches/batman-adv_correctly_set_the_data_field_in_the_TT_REPONSE_pack=
et
>> .patch using plaintext:
>> patching file translation-table.c
>> Hunk #1 FAILED at 1054.
>> Hunk #2 succeeded at 632 with fuzz 2 (offset -448 lines).
>> 1 out of 2 hunks FAILED -- saving rejects to file translation-table.c.re=
j
>> Patch failed! =C2=A0Please fix
>> ./patches/batman-adv_correctly_set_the_data_field_in_the_TT_REPONSE_pack=
et.
>> patch!
>
> works for me. Do you have additional patches in your patches folder which=
 are
> incompatible ?
>
> Regards,
> Marek
>



--=20
Filippo Sallemi
