Return-Path: <cem.f.karan.civ@mail.mil>
From: "Karan, Cem F CIV (US)" <cem.f.karan.civ@mail.mil>
Date: Wed, 5 Sep 2012 13:32:29 +0000
Message-ID: <A677A9FB362B2F499BEFD6F80687FE972AF15A15@umechphe.easf.csd.disa.mil>
References: <A677A9FB362B2F499BEFD6F80687FE972AF159C4@umechphe.easf.csd.disa.mil>
 <1522799.RKjDCIBmI1@bentobox>
In-Reply-To: <1522799.RKjDCIBmI1@bentobox>
Content-Language: en-US
Content-Type: multipart/signed; micalg=SHA1;
 protocol="application/x-pkcs7-signature";
 boundary="----=_NextPart_000_000C_01CD8B49.4128F890"
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Batman, TTL, broadcast, etc. (UNCLASSIFIED)
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
To: Sven Eckelmann <sven@narfation.org>, "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

------=_NextPart_000_000C_01CD8B49.4128F890
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Classification: UNCLASSIFIED
Caveats: NONE

OK, based on the answers below, I have a few more questions.

1) Is there any way for a user program to communicate with batman if =
certain
packets need special handling?  I don't mind if I have to mark each =
packet
individually, or if I have to do something else interesting, but if I =
can
mark a packet as special, then I can hack code into batman to set the =
TTL
field the way I need it.

2) Does batman rely on multicast in any way for its own operation?  That =
is,
for something that keeps the network running well.  If not, I can force =
all
multicast packets to have a TTL of 1.  This still requires some way of
marking my own IP packets as multicast packets in a manner that batman =
can
recognize, but I'm willing to do that, if it will help.

Thanks,
Cem Karan

> -----Original Message-----
> From: Sven Eckelmann [mailto:sven@narfation.org]
> Sent: Tuesday, September 04, 2012 9:05 AM
> To: b.a.t.m.a.n@lists.open-mesh.org
> Cc: Karan, Cem F CIV (US); Linus L=FCssing
> Subject: Re: [B.A.T.M.A.N.] Batman, TTL, broadcast, etc. =
(UNCLASSIFIED)
>=20
> On Tuesday 04 September 2012 12:48:00 Karan, Cem F CIV wrote:
> [...]
> > 1) I'm guessing from the following pages (which only describe =
roaming
> > and announcement behaviors) that the TTL field of all packets is
> > decremented by 1.  Is this true?
> > http://www.open-mesh.org/projects/batman-adv/wiki/Client-roaming
> > =
http://www.open-mesh.org/projects/batman-adv/wiki/Client-announcement
>=20
> TTL fields of the batman-adv specific TTL fields are decremented by =
one
> for each hop.
>=20
> > 2) Follow up to question 1; are the TTL fields of Batman packets and
> > IP packets linked in some way?  The library I'm using (zeromq,
> > http://www.zeromq.org/) has a reliable multicast transport built on
> > top of OpenPGM (http://code.google.com/p/openpgm/).  My plan is to
> > simulate reliable 1-hop broadcast by using reliable multicast and
> > setting the TTL field to 1.  However, this will only affect the IP
> > layer.  Unless batman also decrements the TTL field of the IP =
packets
> > traveling over it, I'm kind of stuck.
>=20
> No, batman-adv is a distributed switch on layer 2. So it operates on a
> different layer and has no knowledge of IP or its TTL field (please
> ignore the gateway feature for now... this is the only exception were
> it accesses L3 stuff).
>=20
> > 3) Finally, does batman have the equivalent of multicast or (better
> > yet) broadcast for data packets?  That is, if I send something to a
> > multicast IP address which all of its 1-hop neighbors are listening
> > to, will all of them listen to the packet simultaneously, or will it
> > act like a series of unicast messages?
>=20
> It currently has layer 2 broadcast support (it resents broadcast
> packets 3 times to increase the propability for a successful tx).
> Multicast is handled as multicast. Linus Luessing has a patchset to
> implement optimized multicast [1]. I am not sure about the current
> state. But maybe he can give more detailed information about it. But
> you should know that the optimized implementation may use unicast in
> some scenarios.
>=20
> Kind regards,
> 	Sven
>=20
> [1] http://www.open-mesh.org/projects/batman-adv/wiki/Multicast-ideas

Classification: UNCLASSIFIED
Caveats: NONE



------=_NextPart_000_000C_01CD8B49.4128F890
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
A1UEAxMPRE9EIEVNQUlMIENBLTI5MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAkmIv
QcIgABYGVWSfvaeIFW6Cm0jBhXe9AqsM2fErYIEBuj51cI4Spqc4hJCz6UCAEtxqylHNrS2GEMxE
vA7FWDgZshQyJUFUWFxDDshscw/DDBgYFgSaUj2BonHOPDIAn3FVuvjONnceIbcolOc9Pqb2wHox
YJEol3ciUPLGk26yG8VBxvmhN/sQv9pWpvtSTV+/78SWdyjlMv/o4RjMQ1IYrI13mnJM6J0DXrCi
7+Td0ufmp6ZSreGYCJZKQ8xzPUuijYnv3IJMuEqAJGUrHpGC9QT2ch9XGEAX8DlRto/ziTtn91hO
Srza+Q7BwAy98whx+IMPyS6AlfSFDs6uqQIDAQABo4ICHDCCAhgwDgYDVR0PAQH/BAQDAgGGMB8G
A1UdIwQYMBaAFEl0uwxeunr+AlTve6DGlcYJgHCWMB0GA1UdDgQWBBS4Q4NkIXrucIHepd4MYCiH
eK5eeDASBgNVHRMBAf8ECDAGAQH/AgEAMAwGA1UdJAQFMAOAAQAwZgYDVR0gBF8wXTALBglghkgB
ZQIBCwUwCwYJYIZIAWUCAQsJMAsGCWCGSAFlAgELETALBglghkgBZQIBCxIwCwYJYIZIAWUCAQsT
MAwGCmCGSAFlAwIBAxowDAYKYIZIAWUDAgEDGzA3BgNVHR8EMDAuMCygKqAohiZodHRwOi8vY3Js
LmRpc2EubWlsL2NybC9ET0RST09UQ0EyLmNybDCCAQEGCCsGAQUFBwEBBIH0MIHxMDoGCCsGAQUF
BzAChi5odHRwOi8vY3JsLmRpc2EubWlsL2lzc3VlZHRvL0RPRFJPT1RDQTJfSVQucDdjMCAGCCsG
AQUFBzABhhRodHRwOi8vb2NzcC5kaXNhLm1pbDCBkAYIKwYBBQUHMAKGgYNsZGFwOi8vY3JsLmdk
cy5kaXNhLm1pbC9jbiUzZERvRCUyMFJvb3QlMjBDQSUyMDIlMmNvdSUzZFBLSSUyY291JTNkRG9E
JTJjbyUzZFUuUy4lMjBHb3Zlcm5tZW50JTJjYyUzZFVTP2Nyb3NzQ2VydGlmaWNhdGVQYWlyO2Jp
bmFyeTANBgkqhkiG9w0BAQUFAAOCAQEALGsseTXb8B4ch3ur4ehpajeL23pPVWBplS9TncbKQ7bU
N5HWA11+WrG4HfeegdOuUFQwpG9LLrsUGxeqXBDTlHoxOZakVHn16VYuVcMbFuqqAsjPUfcygSLG
NDqpzZqqSJPH6fseMn5xxHbwRVQSHVXqvVwyhzquk5pumSJfqFE17rJTYF/2T0W4FoQdZVXNFcoQ
AR+p0pynV5Gj1+ewhj0t9Ik62Ml3cFDGbO/y65j4EKo92shcKa3OuHNJTKGSu+btzbqCGmMhGWX0
Bhm/g6pz5dMbsZj/Rd/7Scxz6OLnB5YAMel/2SQI58pEekgGw0LYP/l5h6U3khaphCCSYzGCAv4w
ggL6AgEBMGQwXTELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD1UuUy4gR292ZXJubWVudDEMMAoGA1UE
CxMDRG9EMQwwCgYDVQQLEwNQS0kxGDAWBgNVBAMTD0RPRCBFTUFJTCBDQS0yOQIDFNx/MAkGBSsO
AwIaBQCgggFvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTEyMDkw
NTEzMzE0MFowIwYJKoZIhvcNAQkEMRYEFDb3gQOMDriXtQq1GeNk9j19AcgHMCQGCSqGSIb3DQEJ
DzEXMBUwCgYIKoZIhvcNAwcwBwYFKw4DAhowcwYJKwYBBAGCNxAEMWYwZDBdMQswCQYDVQQGEwJV
UzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNEb0QxDDAKBgNVBAsTA1BLSTEY
MBYGA1UEAxMPRE9EIEVNQUlMIENBLTI5AgMU3IwwdQYLKoZIhvcNAQkQAgsxZqBkMF0xCzAJBgNV
BAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0RvRDEMMAoGA1UECxMD
UEtJMRgwFgYDVQQDEw9ET0QgRU1BSUwgQ0EtMjkCAxTcjDANBgkqhkiG9w0BAQEFAASCAQAVG3iB
X5g703xM+jQzyzGjNaGEkBGYS4YtPDQ073To6ZOGoHP5ZGq3w95BYJe7QngEeJ9LWoJhzXzVVHoP
DVJVUjsJDA4Qc4a4HC12Bz9R3998aCoNHubIEigSnmI7J6bzzkm3PaFaAWTAgpIZx99EoMMtO+Px
3CiKQm5pvrRuICp4lhc4TQy+w47rNj4R7wZtYshuyGJkfcwOEGfEBv6YOzP8yudiS8LlMumi41NT
HEaeF+0B/ZVIvusToRN1a/8Ej8Lo0tw8prR7Jk7HkRB89hyKufYOHi49J8Oc9kUUYnxh7F/Tn19V
ANXiEMkTYNRzyM9pejA3RYWwCbwcfbVQAAAAAAAA

------=_NextPart_000_000C_01CD8B49.4128F890--
