Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <11476276.Zba4Nueg8B@bentobox>
References: <CAHD-aqKfNck0Z4Zqw_MJYzTFN=dEVp=Xxu6SfgRSwtOeCpPXnw@mail.gmail.com>
 <CAHD-aq+pkXDfaVXtvMtSV6OK-umobdvYrUMeVYkW1Rsh7uM7iQ@mail.gmail.com>
 <201211261840.20610.lindner_marek@yahoo.de> <11476276.Zba4Nueg8B@bentobox>
From: Gui Iribarren <gui@altermundi.net>
Date: Sun, 2 Dec 2012 10:19:44 -0300
Message-ID: <CAHD-aqLUc7YAsmgOdGS2nxdU06U3KTbCAtjXHa4v_64fzHNhWg@mail.gmail.com>
Content-Type: multipart/mixed; boundary=047d7bae4792bd655704cfde7d3c
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv boot setup scheme on OpenWRT
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--047d7bae4792bd655704cfde7d3c
Content-Type: text/plain; charset=UTF-8

Really Sorry for the whitespace headaches :( hope to get it straight this time.

As we discussed on irc with Marek, here's a first stab at netifd integration.
I'm surprised at how simple it actually is to add a custom "proto" with netifd

No race condition with this approach, at least on the hardware i have
at hand (ubnt2 , and tplinks)

an example uci config scheme changes from

batman-adv.bat0=mesh
batman-adv.bat0.interfaces='mesh0 mesh1 mesh2'
batman-adv.bat0.bridge_loop_avoidance=1
network.mesh{0,1,2}=interface
network.mesh{0,1,2}.proto=none
network.mesh{0,1,2}.mtu=1528
wireless.@wifi-iface[]=wifi-iface
wireless.@wifi-iface[].network=mesh{0,1,2}
wireless.@wifi-iface[].mode=adhoc

to

batman-adv.bat0=mesh
batman-adv.bat0.bridge_loop_avoidance=1
network.mesh{0,1,2}=interface
network.mesh{0,1,2}.proto=batadv
network.mesh{0,1,2}.mesh=bat0
network.mesh{0,1,2}.mtu=1528
wireless.@wifi-iface[1]=wifi-iface
wireless.@wifi-iface[1].network=mesh{0,1,2}
wireless.@wifi-iface[1].mode=adhoc

So /etc/config/batman-adv now deals only with bat0 tweakable parameters,
/etc/config/network defines interfaces to be added to bat0
and /etc/config/wireless is unchanged

and netifd is responsible of avoiding race conditions
of course, this makes batman-adv package (on openwrt) depend on
netifd, but openwrt devs are pushing it that way (and it's finally
looking like an elegant move after all ;) )

Cheers!

On Mon, Nov 26, 2012 at 7:45 AM, Sven Eckelmann <sven@narfation.org> wrote:
> On Monday 26 November 2012 18:40:20 Marek Lindner wrote:
>> On Friday, November 23, 2012 22:00:47 Gui Iribarren wrote:
>> > Boring bootlog at http://pastebin.com/59FEPttY
>> >
>> > Proposed patch follows (against current batman-adv in openwrt 'packages'
>> > feed)
>> >
>> > Signed-off-by: Gui Iribarren <gui@altermundi.net>
>>
>> I made the necessary changes myself after I successfully de-scrambled your
>> patch. You will find the patch in OpenWrt trunk. Give it try!
>> Next time, please configure your mail client to not wrap lines.
>
> http://lxr.linux.no/linux+v2.6.30/Documentation/email-clients.txt
>
> Kind regards,
>         Sven

--047d7bae4792bd655704cfde7d3c
Content-Type: application/octet-stream; 
	name="batman-adv-netifd-proto-batadv.patch"
Content-Disposition: attachment; 
	filename="batman-adv-netifd-proto-batadv.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ha86ovqq1

ZGlmZiAtLWdpdCBhL2ZpbGVzL2V0Yy9jb25maWcvYmF0bWFuLWFkdiBiL2ZpbGVzL2V0Yy9jb25m
aWcvYmF0bWFuLWFkdgppbmRleCBmYjdiMzg0Li5mNzc1ZDgwIDEwMDY0NAotLS0gYS9maWxlcy9l
dGMvY29uZmlnL2JhdG1hbi1hZHYKKysrIGIvZmlsZXMvZXRjL2NvbmZpZy9iYXRtYW4tYWR2CkBA
IC0xLDYgKzEsNSBAQAogCiBjb25maWcgJ21lc2gnICdiYXQwJwotCW9wdGlvbiAnaW50ZXJmYWNl
cycgJ21lc2gnCiAJb3B0aW9uICdhZ2dyZWdhdGVkX29nbXMnCiAJb3B0aW9uICdhcF9pc29sYXRp
b24nCiAJb3B0aW9uICdib25kaW5nJwpkaWZmIC0tZ2l0IGEvZmlsZXMvZXRjL2hvdHBsdWcuZC9p
ZmFjZS85OS1iYXRtYW4tYWR2IGIvZmlsZXMvZXRjL2hvdHBsdWcuZC9pZmFjZS85OS1iYXRtYW4t
YWR2CmRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NAppbmRleCA5MjA2YzQyLi4wMDAwMDAwCi0tLSBh
L2ZpbGVzL2V0Yy9ob3RwbHVnLmQvaWZhY2UvOTktYmF0bWFuLWFkdgorKysgL2Rldi9udWxsCkBA
IC0xLDEyICswLDAgQEAKLSMhL2Jpbi9zaAotCi0uIC9saWIvYmF0bWFuLWFkdi9jb25maWcuc2gK
LQotYmF0X2xvYWRfbW9kdWxlCi1jb25maWdfbG9hZCBiYXRtYW4tYWR2Ci0KLWNhc2UgIiRBQ1RJ
T04iIGluCi0gICAgICAgIGlmdXApCi0gICAgICAgICAgICAgICAgWyAtZCAvc3lzL2NsYXNzL25l
dC8kREVWSUNFL2JhdG1hbl9hZHYvIF0gJiYgY29uZmlnX2ZvcmVhY2ggYmF0X2FkZF9pbnRlcmZh
Y2UgbWVzaCAiJERFVklDRSIKLSAgICAgICAgICAgICAgICA7OwotZXNhYwpkaWZmIC0tZ2l0IGEv
ZmlsZXMvZXRjL2hvdHBsdWcuZC9uZXQvOTktYmF0bWFuLWFkdiBiL2ZpbGVzL2V0Yy9ob3RwbHVn
LmQvbmV0Lzk5LWJhdG1hbi1hZHYKaW5kZXggNDcxMzJjMS4uZjBjMzkxZiAxMDA2NDQKLS0tIGEv
ZmlsZXMvZXRjL2hvdHBsdWcuZC9uZXQvOTktYmF0bWFuLWFkdgorKysgYi9maWxlcy9ldGMvaG90
cGx1Zy5kL25ldC85OS1iYXRtYW4tYWR2CkBAIC05LDcgKzksNCBAQCBjYXNlICIkQUNUSU9OIiBp
bgogCWFkZCkKIAkJWyAtZCAvc3lzL2NsYXNzL25ldC8kSU5URVJGQUNFL21lc2gvIF0gJiYgYmF0
X2NvbmZpZyAiJElOVEVSRkFDRSIKIAkJOzsKLQlyZW1vdmUpCi0JCVsgLWQgL3N5cy9jbGFzcy9u
ZXQvJElOVEVSRkFDRS9iYXRtYW5fYWR2LyBdICYmIGNvbmZpZ19mb3JlYWNoIGJhdF9kZWxfaW50
ZXJmYWNlIG1lc2ggIiRJTlRFUkZBQ0UiCi0JCTs7CiBlc2FjCmRpZmYgLS1naXQgYS9maWxlcy9s
aWIvYmF0bWFuLWFkdi9jb25maWcuc2ggYi9maWxlcy9saWIvYmF0bWFuLWFkdi9jb25maWcuc2gK
aW5kZXggMzEzZGQzYS4uZDA4MTBiOCAxMDA2NDQKLS0tIGEvZmlsZXMvbGliL2JhdG1hbi1hZHYv
Y29uZmlnLnNoCisrKyBiL2ZpbGVzL2xpYi9iYXRtYW4tYWR2L2NvbmZpZy5zaApAQCAtNDEsMzcg
KzQxLDMgQEAgYmF0X2NvbmZpZygpCiAJWyAtbiAiJGFwX2lzb2xhdGlvbiIgXSAmJiBlY2hvICRh
cF9pc29sYXRpb24gPiAvc3lzL2NsYXNzL25ldC8kbWVzaC9tZXNoL2FwX2lzb2xhdGlvbgogCVsg
LW4gIiRicmlkZ2VfbG9vcF9hdm9pZGFuY2UiIF0gJiYgZWNobyAkYnJpZGdlX2xvb3BfYXZvaWRh
bmNlID4gL3N5cy9jbGFzcy9uZXQvJG1lc2gvbWVzaC9icmlkZ2VfbG9vcF9hdm9pZGFuY2UKIH0K
LQotYmF0X2FkZF9pbnRlcmZhY2UoKQotewotCWxvY2FsIG1lc2g9IiQxIgotCWxvY2FsIGludGVy
ZmFjZT0iJDIiCi0JbG9jYWwgaW50ZXJmYWNlcwotCi0JY29uZmlnX2dldCBpbnRlcmZhY2VzICRt
ZXNoIGludGVyZmFjZXMKLQlmb3IgaWZhY2UgaW4gJGludGVyZmFjZXM7IGRvCi0JCVsgLWYgIi9z
eXMvY2xhc3MvbmV0LyRpZmFjZS9iYXRtYW5fYWR2L21lc2hfaWZhY2UiIF0gfHwgewotCQkJaWZh
Y2U9JCh1Y2kgLXEgLVAvdmFyL3N0YXRlIGdldCBuZXR3b3JrLiRpZmFjZS5pZm5hbWUpCi0JCQlb
IC1mICIvc3lzL2NsYXNzL25ldC8kaWZhY2UvYmF0bWFuX2Fkdi9tZXNoX2lmYWNlIiBdIHx8IGNv
bnRpbnVlCi0JCX0KLQkKLQkJWyAiJGlmYWNlIiA9ICIkaW50ZXJmYWNlIiBdICYmIGVjaG8gJG1l
c2ggPiAvc3lzL2NsYXNzL25ldC8kaWZhY2UvYmF0bWFuX2Fkdi9tZXNoX2lmYWNlCi0JZG9uZQot
fQotCi1iYXRfZGVsX2ludGVyZmFjZSgpCi17Ci0JbG9jYWwgbWVzaD0iJDEiCi0JbG9jYWwgaW50
ZXJmYWNlPSIkMiIKLQlsb2NhbCBpbnRlcmZhY2VzCi0KLQljb25maWdfZ2V0IGludGVyZmFjZXMg
JG1lc2ggaW50ZXJmYWNlcwotCWZvciBpZmFjZSBpbiAkaW50ZXJmYWNlczsgZG8KLQkJWyAtZiAi
L3N5cy9jbGFzcy9uZXQvJGlmYWNlL2JhdG1hbl9hZHYvbWVzaF9pZmFjZSIgXSB8fCB7Ci0JCQlp
ZmFjZT0kKHVjaSAtcSAtUC92YXIvc3RhdGUgZ2V0IG5ldHdvcmsuJGlmYWNlLmlmbmFtZSkKLQkJ
CVsgLWYgIi9zeXMvY2xhc3MvbmV0LyRpZmFjZS9iYXRtYW5fYWR2L21lc2hfaWZhY2UiIF0gfHwg
Y29udGludWUKLQkJfQotCi0JCVsgIiRpZmFjZSIgPSAiJGludGVyZmFjZSIgXSAmJiBlY2hvIG5v
bmUgPiAvc3lzL2NsYXNzL25ldC8kaWZhY2UvYmF0bWFuX2Fkdi9tZXNoX2lmYWNlCi0JZG9uZQot
fQpkaWZmIC0tZ2l0IGEvZmlsZXMvbGliL25ldGlmZC9wcm90by9iYXRhZHYuc2ggYi9maWxlcy9s
aWIvbmV0aWZkL3Byb3RvL2JhdGFkdi5zaApuZXcgZmlsZSBtb2RlIDEwMDc1NQppbmRleCAwMDAw
MDAwLi42MzJhMjA5Ci0tLSAvZGV2L251bGwKKysrIGIvZmlsZXMvbGliL25ldGlmZC9wcm90by9i
YXRhZHYuc2gKQEAgLTAsMCArMSwzMCBAQAorIyEvYmluL3NoCisKKy4gL2xpYi9mdW5jdGlvbnMu
c2gKKy4gLi4vbmV0aWZkLXByb3RvLnNoCitpbml0X3Byb3RvICIkQCIKKworcHJvdG9fYmF0YWR2
X2luaXRfY29uZmlnKCkgeworCXByb3RvX2NvbmZpZ19hZGRfc3RyaW5nICJtZXNoIgorfQorCitw
cm90b19iYXRhZHZfc2V0dXAoKSB7CisJbG9jYWwgY29uZmlnPSIkMSIKKwlsb2NhbCBpZmFjZT0i
JDIiCisKKwlsb2NhbCBtZXNoCisJanNvbl9nZXRfdmFycyBtZXNoCisKKwllY2hvICIkbWVzaCIg
PiAiL3N5cy9jbGFzcy9uZXQvJGlmYWNlL2JhdG1hbl9hZHYvbWVzaF9pZmFjZSIKKwlwcm90b19p
bml0X3VwZGF0ZSAiJGlmYWNlIiAxCisJcHJvdG9fc2VuZF91cGRhdGUgIiRjb25maWciCit9CisK
K3Byb3RvX2JhdGFkdl90ZWFyZG93bigpIHsKKwlsb2NhbCBjb25maWc9IiQxIgorCWxvY2FsIGlm
YWNlPSIkMiIKKworCWVjaG8gIm5vbmUiID4gIi9zeXMvY2xhc3MvbmV0LyRpZmFjZS9iYXRtYW5f
YWR2L21lc2hfaWZhY2UiIHx8IHRydWUKK30KKworYWRkX3Byb3RvY29sIGJhdGFkdgo=
--047d7bae4792bd655704cfde7d3c--
