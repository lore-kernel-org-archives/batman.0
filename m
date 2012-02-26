Return-Path: <tonyputi@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFevQmN7t5R52R6dmzz630OHi1g=5z01-q-UTMMR04iJFWXtbw@mail.gmail.com>
References: <CAFevQmN-RVQookzL-M9_G0xGKJJvAp5QXCqRfwf+X8dvWM9-Pw@mail.gmail.com>
	<201202100053.46289.lindner_marek@yahoo.de>
	<CAFevQmP9EDXbAVeO+9cvfhJ2i8rWeNo3PW8uTcUZkpazohsj3A@mail.gmail.com>
	<201202111808.54341.lindner_marek@yahoo.de>
	<CAFevQmN7t5R52R6dmzz630OHi1g=5z01-q-UTMMR04iJFWXtbw@mail.gmail.com>
From: Filippo Sallemi <tonyputi@gmail.com>
Date: Sun, 26 Feb 2012 18:50:25 +0100
Message-ID: <CAFevQmM3MyAjsT0-W6rf=3e1fqpiMSsbz4o4yGZjFBLAiQo_sA@mail.gmail.com>
Content-Type: multipart/mixed; boundary=14dae93409791b8b4304b9e1a206
Subject: Re: [B.A.T.M.A.N.] /lib/batman-adv/config.sh
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

--14dae93409791b8b4304b9e1a206
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

oopps. I've miss the files

Il 26 febbraio 2012 18:49, Filippo Sallemi <tonyputi@gmail.com> ha scritto:
> Ok in this email my proposal patch.
> I've to sleep 4s if you have an ap + adhoc vifs.
>
> [ "$(echo $interface | awk '$0 ~ /^wlan[0-9]*/')" ] && sleep 4s
>
> For convenience I sleep only if an wlan was triggered. If you have
> only one interface in adhoc mode per radio 3 seconds are enought.
>
> bye
>
> ---------- Messaggio inoltrato ----------
> Da: Marek Lindner <lindner_marek@yahoo.de>
> Date: 11 febbraio 2012 11:08
> Oggetto: Re: /lib/batman-adv/config.sh
> A: Filippo Sallemi <tonyputi@gmail.com>
>
>
> On Friday, February 10, 2012 01:21:21 you wrote:
>> > Yeah - looks good.
>> > I still don't get why we don't need to wait 3/5 seconds anymore. Can y=
ou
>> > explain this ?
>>
>> No i'm wrong we need to wait 3 seconds... i think that the sleep call
>> could be moved to hotplug.d/99-batman-adv when an interface is added
>> to mesh interface.
>> I need some time.
>
> Ok - I left the "sleep 3s" in the file. I applied your config_bat/bat_con=
fig
> as well as the forgotten ap_isolation config fix.
>
> Since the for loop does not fix the wait problem why do you wish to chang=
e it?
> I am referring to your suggested change:
>
> # Load network config here just in case!
> config_load network
> for iface in $interfaces; do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# copy iface into ifname
> =C2=A0 =C2=A0 =C2=A0 =C2=A0local ifname=3D$iface
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[ -f "/sys/class/net/$ifname/batman_adv/mesh_i=
face" ] || {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# if ifname was no=
t found try to find it via uci config
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config_get ifname =
$iface ifname
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[ -f "/sys/class/n=
et/$ifname/batman_adv/mesh_iface" ] ||
> continue
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[ "$ifname" =3D "$interface" ] && echo $mesh >
> /sys/class/net/$ifname/batman_adv/mesh_iface
> done
>
> bat_add_interface() and bat_del_interface() have the same loop but we onl=
y
> change one ? The only difference I can see is another added variable and =
not
> calling "uci -q -P/var/state get network.$iface.ifname". Why ?
>
> Cheers,
> Marek
>
>
> --
> Filippo Sallemi



--=20
Filippo Sallemi

--14dae93409791b8b4304b9e1a206
Content-Type: application/x-gzip; name="files.tar.gz"
Content-Disposition: attachment; filename="files.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gz4djea40

H4sIAABwSk8AA+1d/2/jthXPrxb2R7BJ0CQFbIukSNm5XYHi0AIFhnYobtjQogtkS3bcsy3PcpLd
ere/faQkW6JsSbYiUS72PjgkDkU/Unp8X/j4nm4ym3tB39uM+4/+ZjV/mvbc/tLb9HvB87K/8f69
6Y6cwOsPh+L3ZuEsu477LK+FzRfHwRSwLEv+xjYz079DMJtfYGxjahPL5uzCJBbF9AKZR9J/FZ6C
jbNG6GISOPO5t5jl9Su7/gfF1Rf90WzZDx4No4f689mon/C5P/aXk9m0Jy9GHx/mvuOipIdoF8sA
XV5/8+799z/+cIlmS6PjuO6d0en8grou6gcfg/547gRBuKquv//h/bc/fffNu2/7Cy947KNf0Zdf
opi2ICso7XpcltOIJvIgp6pQmvhrzxk/yomKi+7DbLnx1hNn7CE5anaQN2+Mztpb+M/eEdM+ZkjX
m5cP6QXO2Gib+2JZh/Kf4XtG+HfL4FTBj1Ei/5Zl2xn5p4TaIP86kJJ/uXQjVt/e/W505v7YmYer
9+3lNb7cNjjT6dqbOhvPffCniwCN/KU7W07RZO1MF95y42xm/hJNX4Q4L92Xmbt5lH8sfNeTvwMh
GqFcobkvtIn37M2RvxbyE8rLs6D/6K8eVt7SmW8+oudZEH7TMDqxmE29zd4MLq/lJC+z7cp3trPc
9o3/Vvqod7DtqbQq/ZV73HZPN2Z7hw8h1TG8tUyf5AGlOu4ald7JE9x23bUo/dTnu+2rtCr90xzY
9k61KX23HNp1TLFMaFL5GJWBLiOl6Y0ffaReQV/vad3QRIQ/MpONKacmpdBN30ARVeWmYpq7R6hQ
TB51Eb2kF/n6y+6O5G5dhstSoateKiSudt0RjxeyQnW72IvI7QQgpqMsc4WaKhZFNDOiElNOS4RC
WJGfIrqqTCVk5TrLUgwXYwmxSO4SOjvxyhJLhLGEYkpAY7JbOVBI7qSliNxOgj5HKllxYIo0866T
aCX7rYEQyWDueStEA3SFAn/hIdd7ngkX5dbZPN6hWYCevfVHNHf+8xFtfCQN40aR9oQWCiecJt4R
HhCahR7PbImukytvkOtHftUEXWZvO/xC2qmSZB/CVvnkPn1C4n47nbDh7fXt03iGuv9C3b/2n511
X0xwI6yKmJig9eKvP/Qier3ZZOksQm+u8rDirjez5ZNYJ53PRiec/+V13OGt/Li9P4XB4UPZZ27B
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
--14dae93409791b8b4304b9e1a206
Content-Type: text/x-patch; charset=US-ASCII; name="batman-adv.patch"
Content-Disposition: attachment; filename="batman-adv.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gz4djl461

SW5kZXg6IGxpYi9iYXRtYW4tYWR2L2NvbmZpZy5zaAo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaWIvYmF0bWFu
LWFkdi9jb25maWcuc2gJKHJldmlzaW9uZSAzMDczMykKKysrIGxpYi9iYXRtYW4tYWR2L2NvbmZp
Zy5zaAkoY29waWEgbG9jYWxlKQpAQCAtMTQsNiArMTQsNyBAQAogCWNvbmZpZ19nZXQgb3JpZ19p
bnRlcnZhbCAiJG1lc2giIG9yaWdfaW50ZXJ2YWwKIAljb25maWdfZ2V0IGhvcF9wZW5hbHR5ICIk
bWVzaCIgaG9wX3BlbmFsdHkKIAljb25maWdfZ2V0IHZpc19tb2RlICIkbWVzaCIgdmlzX21vZGUK
Kwljb25maWdfZ2V0IGFwX2lzb2xhdGlvbiAiJG1lc2giIGFwX2lzb2xhdGlvbgogCiAJWyAtbiAi
JG9yaWdfaW50ZXJ2YWwiIF0gJiYgZWNobyAkb3JpZ19pbnRlcnZhbCA+IC9zeXMvY2xhc3MvbmV0
LyRtZXNoL21lc2gvb3JpZ19pbnRlcnZhbAogCVsgLW4gIiRob3BfcGVuYWx0eSIgXSAmJiBlY2hv
ICRob3BfcGVuYWx0eSA+IC9zeXMvY2xhc3MvbmV0LyRtZXNoL21lc2gvaG9wX3BlbmFsdHkKQEAg
LTI1LDIyICsyNiwyNyBAQAogCVsgLW4gIiRnd19tb2RlIiBdICYmIGVjaG8gJGd3X21vZGUgPiAv
c3lzL2NsYXNzL25ldC8kbWVzaC9tZXNoL2d3X21vZGUKIAlbIC1uICIkZ3dfc2VsX2NsYXNzIiBd
ICYmIGVjaG8gJGd3X3NlbF9jbGFzcyA+IC9zeXMvY2xhc3MvbmV0LyRtZXNoL21lc2gvZ3dfc2Vs
X2NsYXNzCiAJWyAtbiAiJHZpc19tb2RlIiBdICYmIGVjaG8gJHZpc19tb2RlID4gL3N5cy9jbGFz
cy9uZXQvJG1lc2gvbWVzaC92aXNfbW9kZQorCVsgLW4gIiRhcF9pc29sYXRpb24iIF0gJiYgZWNo
byAkYXBfaXNvbGF0aW9uID4gL3N5cy9jbGFzcy9uZXQvJG1lc2gvbWVzaC9hcF9pc29sYXRpb24K
IH0KIAogYmF0X2FkZF9pbnRlcmZhY2UoKXsKIAlsb2NhbCBtZXNoPSIkMSIKIAlsb2NhbCBpbnRl
cmZhY2U9IiQyIgotCWxvY2FsIGludGVyZmFjZXMKLQotCXNsZWVwIDNzICMgc29tZSBkZXZpY2Ug
KGF0aCkgaXMgdmVyeSBsYXp5IHRvIHN0YXJ0CisJbG9jYWwgaWZhY2UgaW50ZXJmYWNlcworCQog
CWNvbmZpZ19nZXQgaW50ZXJmYWNlcyAkbWVzaCBpbnRlcmZhY2VzCisJCisJWyAiJChlY2hvICRp
bnRlcmZhY2UgfCBhd2sgJyQwIH4gL153bGFuWzAtOV0qLycpIiBdICYmIHNsZWVwIDRzCisJIyBM
b2FkIG5ldHdvcmsgY29uZmlnIGhlcmUganVzdCBpbiBjYXNlIQorCWNvbmZpZ19sb2FkIG5ldHdv
cmsKIAlmb3IgaWZhY2UgaW4gJGludGVyZmFjZXM7IGRvCi0JCVsgLWYgIi9zeXMvY2xhc3MvbmV0
LyRpZmFjZS9iYXRtYW5fYWR2L21lc2hfaWZhY2UiIF0gfHwgewotCQkJaWZhY2U9JCh1Y2kgLXEg
LVAvdmFyL3N0YXRlIGdldCBuZXR3b3JrLiRpZmFjZS5pZm5hbWUpCi0JCQlbIC1mICIvc3lzL2Ns
YXNzL25ldC8kaWZhY2UvYmF0bWFuX2Fkdi9tZXNoX2lmYWNlIiBdIHx8IGNvbnRpbnVlCisJCWxv
Y2FsIGlmbmFtZT0iJGlmYWNlIgorCQlbIC1mICIvc3lzL2NsYXNzL25ldC8kaWZuYW1lL2JhdG1h
bl9hZHYvbWVzaF9pZmFjZSIgXSB8fCB7CisJCQljb25maWdfZ2V0IGlmbmFtZSAkaWZhY2UgaWZu
YW1lCisJCQlbIC1mICIvc3lzL2NsYXNzL25ldC8kaWZuYW1lL2JhdG1hbl9hZHYvbWVzaF9pZmFj
ZSIgXSB8fCBjb250aW51ZQogCQl9Ci0JCi0JCVsgIiRpZmFjZSIgPSAiJGludGVyZmFjZSIgXSAm
JiBlY2hvICRtZXNoID4gL3N5cy9jbGFzcy9uZXQvJGlmYWNlL2JhdG1hbl9hZHYvbWVzaF9pZmFj
ZQorCQkKKwkJWyAiJGlmbmFtZSIgPSAiJGludGVyZmFjZSIgXSAmJiBlY2hvICRtZXNoID4gL3N5
cy9jbGFzcy9uZXQvJGlmbmFtZS9iYXRtYW5fYWR2L21lc2hfaWZhY2UKIAlkb25lCiB9CiAKQEAg
LTUwLDEyICs1NiwxNiBAQAogCWxvY2FsIGludGVyZmFjZXMKIAogCWNvbmZpZ19nZXQgaW50ZXJm
YWNlcyAkbWVzaCBpbnRlcmZhY2VzCisJCisJIyBMb2FkIG5ldHdvcmsgY29uZmlnIGhlcmUganVz
dCBpbiBjYXNlIQorCWNvbmZpZ19sb2FkIG5ldHdvcmsKIAlmb3IgaWZhY2UgaW4gJGludGVyZmFj
ZXM7IGRvCi0JCVsgLWYgIi9zeXMvY2xhc3MvbmV0LyRpZmFjZS9iYXRtYW5fYWR2L21lc2hfaWZh
Y2UiIF0gfHwgewotCQkJaWZhY2U9JCh1Y2kgLXEgLVAvdmFyL3N0YXRlIGdldCBuZXR3b3JrLiRp
ZmFjZS5pZm5hbWUpCi0JCQlbIC1mICIvc3lzL2NsYXNzL25ldC8kaWZhY2UvYmF0bWFuX2Fkdi9t
ZXNoX2lmYWNlIiBdIHx8IGNvbnRpbnVlCisJCWxvY2FsIGlmbmFtZT0iJGlmYWNlIgorCQlbIC1m
ICIvc3lzL2NsYXNzL25ldC8kaWZuYW1lL2JhdG1hbl9hZHYvbWVzaF9pZmFjZSIgXSB8fCB7CisJ
CQljb25maWdfZ2V0IGlmbmFtZSAkaWZhY2UgaWZuYW1lCisJCQlbIC1mICIvc3lzL2NsYXNzL25l
dC8kaWZuYW1lL2JhdG1hbl9hZHYvbWVzaF9pZmFjZSIgXSB8fCBjb250aW51ZQogCQl9CiAKLQkJ
WyAiJGlmYWNlIiA9ICIkaW50ZXJmYWNlIiBdICYmIGVjaG8gbm9uZSA+IC9zeXMvY2xhc3MvbmV0
LyRpZmFjZS9iYXRtYW5fYWR2L21lc2hfaWZhY2UKKwkJWyAiJGlmbmFtZSIgPSAiJGludGVyZmFj
ZSIgXSAmJiBlY2hvIG5vbmUgPiAvc3lzL2NsYXNzL25ldC8kaWZuYW1lL2JhdG1hbl9hZHYvbWVz
aF9pZmFjZQogCWRvbmUKIH0KSW5kZXg6IHVzci9zYmluL2JhdG1hbi1hZHYKPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQot
LS0gdXNyL3NiaW4vYmF0bWFuLWFkdgkocmV2aXNpb25lIDMwNzMzKQorKysgdXNyL3NiaW4vYmF0
bWFuLWFkdgkoY29waWEgbG9jYWxlKQpAQCAtMSw2ICsxLDcgQEAKLSMhL2Jpbi9zaCAvZXRjL3Jj
LmNvbW1vbgorIyEvYmluL3NoCiAjIENvcHlyaWdodCAoQykgMjAxMSBPcGVuV3J0Lm9yZwogCisu
IC9ldGMvZnVuY3Rpb25zLnNoCiAuIC9saWIvYmF0bWFuLWFkdi9jb25maWcuc2gKIAogc3RhcnRf
bWVzaCgpIHsKQEAgLTQ0LDMgKzQ1LDE1IEBACiAJCWNvbmZpZ19mb3JlYWNoIHN0b3BfbWVzaCBt
ZXNoCiAJZmkKIH0KKworcmVzdGFydCgpIHsKKwlzdG9wICQxCisJc3RhcnQgJDEKK30KKworY2Fz
ZSAiJDEiIGluCisJc3RhcnQpIHN0YXJ0ICQyIDs7CisJc3RvcCkgc3RvcCAkMiA7OworCXJlc3Rh
cnQpIHJlc3RhcnQgJDIgOzsKKwkqKSBlY2hvICJVc2FnZTogYmF0bWFuLWFkdiA8c3RhcnR8c3Rv
cHxyZXN0YXJ0PiBbbWVzaF0iCitlc2FjCkluZGV4OiBldGMvaG90cGx1Zy5kL25ldC85OS1iYXRt
YW4tYWR2Cj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0KLS0tIGV0Yy9ob3RwbHVnLmQvbmV0Lzk5LWJhdG1hbi1hZHYJKHJl
dmlzaW9uZSAzMDczMykKKysrIGV0Yy9ob3RwbHVnLmQvbmV0Lzk5LWJhdG1hbi1hZHYJKGNvcGlh
IGxvY2FsZSkKQEAgLTYsNyArNiw3IEBACiAKIGNhc2UgIiRBQ1RJT04iIGluCiAJYWRkKQotCQlb
IC1kIC9zeXMvY2xhc3MvbmV0LyRJTlRFUkZBQ0UvbWVzaC8gXSAmJiBjb25maWdfYmF0ICIkSU5U
RVJGQUNFIgorCQlbIC1kIC9zeXMvY2xhc3MvbmV0LyRJTlRFUkZBQ0UvbWVzaC8gXSAmJiBiYXRf
Y29uZmlnICIkSU5URVJGQUNFIgogCQlbIC1kIC9zeXMvY2xhc3MvbmV0LyRJTlRFUkZBQ0UvYmF0
bWFuX2Fkdi8gXSAmJiBjb25maWdfZm9yZWFjaCBiYXRfYWRkX2ludGVyZmFjZSBtZXNoICIkSU5U
RVJGQUNFIgogCQk7OwogCXJlbW92ZSkK
--14dae93409791b8b4304b9e1a206--
