Return-Path: <cem.f.karan.civ@mail.mil>
From: "Karan, Cem F CIV (US)" <cem.f.karan.civ@mail.mil>
Date: Mon, 10 Sep 2012 15:42:15 +0000
Message-ID: <A677A9FB362B2F499BEFD6F80687FE972AF1CF8D@umechphe.easf.csd.disa.mil>
In-Reply-To: <2606499.OtDZNs5MDJ@sven-laptop.home.narfation.org>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha1; boundary="B_3430122062_675513"
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
To: Sven Eckelmann <sven@narfation.org>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

--B_3430122062_675513
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit

On 9/8/12 11:37 AM, "Sven Eckelmann" <sven@narfation.org> wrote:

>On Wednesday 05 September 2012 13:32:29 you wrote:
>> Classification: UNCLASSIFIED
>> Caveats: NONE
>> 
>> OK, based on the answers below, I have a few more questions.
>> 
>> 1) Is there any way for a user program to communicate with batman if
>>certain
>> packets need special handling?  I don't mind if I have to mark each
>>packet
>> individually, or if I have to do something else interesting, but if I
>>can
>> mark a packet as special, then I can hack code into batman to set the
>>TTL
>> field the way I need it.
>
>How would you signal other layers you don't interact with directly? There
>is 
>no special socket API that allows you do modify the batman-adv stuff. But
>you 
>can for example do things like the gateway handling which checks
>different 
>layer 3/4 things and modifies the behaviour slightly.
>
>So it is (depending on the problem) doable, but there is no general
>solution 
>Available.

That was what I was afraid of.  I'll have to do something else then.

>> 2) Does batman rely on multicast in any way for its own operation?
>>That is,
>> for something that keeps the network running well.  If not, I can force
>>all
>> multicast packets to have a TTL of 1.  This still requires some way of
>> marking my own IP packets as multicast packets in a manner that batman
>>can
>> recognize, but I'm willing to do that, if it will help.
>
>Multicast on ethernet... yes. Because it does broadcasts to send OGMs.
>But on 
>IP level - no, batman-adv doesn't work on top of layer 3.
>
>And marking the packets. This could be done using special multicast
>addresses.

That might work for me!  I have few enough nodes that I can assign
numerous special multicast addresses to each node, for each purpose I have
in mind.  I'll have to work on it.  Thank you for the suggestion!

Thanks,
Cem Karan

--B_3430122062_675513
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
QBfwOVG2j/OJO2f3WE5KvNr5DsHADL3zCHH4gw/JLoCV9IUOzq6pAgMBAAGjggIcMIICGDAO
BgNVHQ8BAf8EBAMCAYYwHwYDVR0jBBgwFoAUSXS7DF66ev4CVO97oMaVxgmAcJYwHQYDVR0O
BBYEFLhDg2Qheu5wgd6l3gxgKId4rl54MBIGA1UdEwEB/wQIMAYBAf8CAQAwDAYDVR0kBAUw
A4ABADBmBgNVHSAEXzBdMAsGCWCGSAFlAgELBTALBglghkgBZQIBCwkwCwYJYIZIAWUCAQsR
MAsGCWCGSAFlAgELEjALBglghkgBZQIBCxMwDAYKYIZIAWUDAgEDGjAMBgpghkgBZQMCAQMb
MDcGA1UdHwQwMC4wLKAqoCiGJmh0dHA6Ly9jcmwuZGlzYS5taWwvY3JsL0RPRFJPT1RDQTIu
Y3JsMIIBAQYIKwYBBQUHAQEEgfQwgfEwOgYIKwYBBQUHMAKGLmh0dHA6Ly9jcmwuZGlzYS5t
aWwvaXNzdWVkdG8vRE9EUk9PVENBMl9JVC5wN2MwIAYIKwYBBQUHMAGGFGh0dHA6Ly9vY3Nw
LmRpc2EubWlsMIGQBggrBgEFBQcwAoaBg2xkYXA6Ly9jcmwuZ2RzLmRpc2EubWlsL2NuJTNk
RG9EJTIwUm9vdCUyMENBJTIwMiUyY291JTNkUEtJJTJjb3UlM2REb0QlMmNvJTNkVS5TLiUy
MEdvdmVybm1lbnQlMmNjJTNkVVM/Y3Jvc3NDZXJ0aWZpY2F0ZVBhaXI7YmluYXJ5MA0GCSqG
SIb3DQEBBQUAA4IBAQAsayx5NdvwHhyHe6vh6GlqN4vbek9VYGmVL1OdxspDttQ3kdYDXX5a
sbgd956B065QVDCkb0suuxQbF6pcENOUejE5lqRUefXpVi5VwxsW6qoCyM9R9zKBIsY0OqnN
mqpIk8fp+x4yfnHEdvBFVBIdVeq9XDKHOq6Tmm6ZIl+oUTXuslNgX/ZPRbgWhB1lVc0VyhAB
H6nSnKdXkaPX57CGPS30iTrYyXdwUMZs7/LrmPgQqj3ayFwprc64c0lMoZK75u3NuoIaYyEZ
ZfQGGb+DqnPl0xuxmP9F3/tJzHPo4ucHlgAx6X/ZJAjnykR6SAbDQtg/+XmHpTeSFqmEIJJj
MIIDcDCCAligAwIBAgIBBTANBgkqhkiG9w0BAQUFADBbMQswCQYDVQQGEwJVUzEYMBYGA1UE
ChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNEb0QxDDAKBgNVBAsTA1BLSTEWMBQGA1UE
AxMNRG9EIFJvb3QgQ0EgMjAeFw0wNDEyMTMxNTAwMTBaFw0yOTEyMDUxNTAwMTBaMFsxCzAJ
BgNVBAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0RvRDEMMAoG
A1UECxMDUEtJMRYwFAYDVQQDEw1Eb0QgUm9vdCBDQSAyMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAwCzB9o07rP8/PNZxvrh0IgfscEEV/KtA4weqwcPYn/7aTDq/P8jYKHtL
NgHArEUlw9IOCo+FGGQQPRoTcCpvjtfcjZOzQQ84Ic2tq8I9KgXTVxE3Dc2MUfmT48xGSSGO
FLTNyxQ+OM1yMe6rEvJl6jQuVl3/7mN1y226kTT8nvP0LRy+UMRC31mI/2qz+qhsPctWcXEF
lrufgOWARVlnQbDrw61gpIB1BhecDvRD4JkOG/t/9bPMsoGCsf0ywbi+QaRktWA6WlEwjM7e
QSwZR1xJEGS5dKmHQa99brrBuKG/ZTE6BGf5tbuOkooAY7ix5ow4X4P/UNU7ol1rshDMYwID
AQABoz8wPTAdBgNVHQ4EFgQUSXS7DF66ev4CVO97oMaVxgmAcJYwCwYDVR0PBAQDAgGGMA8G
A1UdEwEB/wQFMAMBAf8wDQYJKoZIhvcNAQEFBQADggEBAJiRjT+JyLv1wGlzKTs1rLqzCHY9
cAmS6YREIQF9FHYb7lFsHY0VNy17MWn0mkS4r0bMNPojywMnGdKDIXUr5+AbmSbchECV6KjS
zPZYXGbvP0qXEIIdugqi3VsGK52nZE7rLgE1pLQ/E61V5NVzqGmbEfGY8jEeb0DU+HifjpGg
b3AEkGaqBivO4XqStX3h4NGW56E6LcyxnR8FRO2HmdNNGnA5wQQM5X7Z8a/XIA7xInolpHOZ
zD+kByeWqKKV7YK5FtOeC4fCwfKI9WLfaN/HvGlR7bFc3FRUKQ8JOZqsA8HbDE2ubwp6Fknx
v5HSOJTT9pUst2zJQraNypCNhdkwggSvMIIDl6ADAgECAgMU3IwwDQYJKoZIhvcNAQEFBQAw
XTELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD1UuUy4gR292ZXJubWVudDEMMAoGA1UECxMDRG9E
MQwwCgYDVQQLEwNQS0kxGDAWBgNVBAMTD0RPRCBFTUFJTCBDQS0yOTAeFw0xMjA3MDIwMDAw
MDBaFw0xNDEyMTQyMzU5NTlaMHIxCzAJBgNVBAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdPVkVS
Tk1FTlQxDDAKBgNVBAsTA0RPRDEMMAoGA1UECxMDUEtJMQwwCgYDVQQLEwNVU0ExHzAdBgNV
BAMTFktBUkFOLkNFTS5GLjEyNTg2MTM3NjMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
AoIBAQCxlvnsphxf1326yh8gTdNaor4bl2Ww6i0DqNRjiqora3IVCLHYpbbfKh01euJdUPf2
b7Pi+lOJe4umxfGPbNi/Dw8d5yhk77O6xSjHPcXNGmLG6BfKaFiLVHMmC7KWZiCu5RYmgUiz
j0GJ13G+GYsOJ54QIS3f+4P10VdUarUknwS7t8VQAHigyqvj2qSxe+6Km45EwwLl5LDYKXOt
2jcVrhgMau831U/IrcS+mR+7zlpMnjgTzXbdrRExZvBq3dVKE/RXF6IE7onw+eip5OG/Ocy6
f9VbCPbOgWzM7TG8K+Z7UsUbHdb3f9mJPn2SP09zqOL+j4Bx2L26Txxlmt4BAgMBAAGjggFh
MIIBXTAfBgNVHSMEGDAWgBS4Q4NkIXrucIHepd4MYCiHeK5eeDA6BgNVHR8EMzAxMC+gLaAr
hilodHRwOi8vY3JsLmRpc2EubWlsL2NybC9ET0RFTUFJTENBXzI5LmNybDAOBgNVHQ8BAf8E
BAMCBSAwIwYDVR0gBBwwGjALBglghkgBZQIBCwkwCwYJYIZIAWUCAQsTMB0GA1UdDgQWBBSv
peAPMKJ8sMknTHIM0mwTNiEBWDBoBggrBgEFBQcBAQRcMFowNgYIKwYBBQUHMAKGKmh0dHA6
Ly9jcmwuZGlzYS5taWwvc2lnbi9ET0RFTUFJTENBXzI5LmNlcjAgBggrBgEFBQcwAYYUaHR0
cDovL29jc3AuZGlzYS5taWwwIwYDVR0RBBwwGoEYY2VtLmYua2FyYW4uY2l2QG1haWwubWls
MBsGA1UdCQQUMBIwEAYIKwYBBQUHCQQxBBMCVVMwDQYJKoZIhvcNAQEFBQADggEBACUndV8e
VUz6HluNDkl5WPJR7U8+KPHDfDo7RIT5JpTD/rtLuUvEdwS+Q1Jp1OBXG3IVe1czrhMsWXcg
h36Vk/gO1NuRg87YK0RURyZcgzfGTvLDTgnRGLXFItJn6JskOgmenjUBSAkhv6wfHZKK0+ns
0wUcIAxv/C56L7omSmM1EPgJDwQ2W1VWjjw9LtJcKn2DgqAoXHOHewqhAEZTLi54dToFhtQv
iH927fzPxIaVTpDXJYQfqtwHKls0uXDVdtxNKUWSOgCIMJStekvD4cIDSO0VfGjIiUd0YWep
kxBD8vmkOn1vfOOg/d4ch7Bo6IuIR/esMjrjkjLLL11j+RQxggHqMIIB5gIBATBkMF0xCzAJ
BgNVBAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0RvRDEMMAoG
A1UECxMDUEtJMRgwFgYDVQQDEw9ET0QgRU1BSUwgQ0EtMjkCAxTcfzAJBgUrDgMCGgUAoF0w
IwYJKoZIhvcNAQkEMRYEFGke3nqypcPh0xKx89z9AJUM7W11MBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTEyMDkxMDE1NDEwMVowDQYJKoZIhvcNAQEBBQAE
ggEAWP71aXStTDrWrjfZ4dDYySIHptXuPIa16OZOQ9RxdmhhTN/r+dr4+uqVmC3wJ84MUY2p
YMmo/9InraeJY5ETmrgMwuH3P4WKcpB3CeOOuIxe8BpiD+gYkKnXHIjSvxRf3KDVDJNaOL2q
3RnI93PLBs4RM0WP6nsq58UukmCU6PRp/XPRblwnOaYMT0Io7OsDjcyOyYAavIwtdu2hN8AA
b02tG6ArTG6kgmYrIVgofvNvabEc7GDFPDSDTe2i1QGbkXDUJmnB8n31qj+b3J1bWAdzwCob
l0iaoNdOPFxK2KfBBGomLSEz68GfRwHpHbykXS1jPppdq/2+pNTpDcPdzQ==

--B_3430122062_675513--
