Message-ID: <49F96044.4070207@informatik.haw-hamburg.de>
Date: Thu, 30 Apr 2009 10:24:36 +0200
From: Maik Wodarz <Maik.Wodarz@informatik.haw-hamburg.de>
MIME-Version: 1.0
References: <209743CECB91EB4F84169A51F300410D1F3137C3F9@MAIL02.ug.kth.se>
	<49F5E0D3.208@gmx.net>
In-Reply-To: <49F5E0D3.208@gmx.net>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms020906060302080104030509"
Subject: Re: [B.A.T.M.A.N.] Masters thesis
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

This is a cryptographically signed message in MIME format.

--------------ms020906060302080104030509
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vojislav and Electra,

Was the protocol implemented yet on a simulation platform like omnet?
For comparing purposes (for example with OLSR) it could be interesting
to simulate the protocol.

Further the package load will be tunnelled through batman network by an
udp tunnel. There was reasons to do this. But why we can not establish
an tcp-tunel on top of the existing tunnels. So earn more overhead but
the delivery of the related packages are granted.

In respect to IPv6: What is the problem with IPv6? The batman protocol
self should work with ipv6? As payload it could be realized by an tunnel
too.

regards

Maik


elektra schrieb:
> Hello Vojislav!
> 
> I have a personal wish list of things that would be great to have in
> Batman. I don't know if any of these would be suitable/interesting for
> you, but I will use the opportunity to post it to the list now:
> 
> *  Modify Batman-0.3.X  in order to support IPv6
> *  Improve Batman with regards to protocol overhead and convergence speed
> *  Get support for other operating systems working (so far it only works
> with Linux)
> *  Implement a minimalistic and power saving Batman client version for
> embedded mobile devices
> *  Modify Batman-0.3.X code so we have an option to compile it without
> policy routing support
> *  Modify the way that Batman-Advanced (Layer 2) deals with
> broadcast/multicast payload packages (on multihop wireless routes there
> is always packet loss, protocols like DHCP use broadcast or multicast
> messages which are not send redundantly and not acknowledged, so these
> protocols which are not designed to deal with a high level of packetloss
> have difficulties to work on a Layer 2 mesh as the number of hops and
> packet loss on the media increases)
> 
> Cheers,
> elektra
> 
> 
> 
> 
> 
> 
>> Hi!
>>
>> My name is Vojislav Marinkovic and I am a student of Electrical
>> Engineering at the Royal Institute of Technology in Stockholm. My
>> major is Communication Networks and right now I am looking for an
>> interesting subject for my masters thesis. While browsing the Internet
>> for some interesting topics, I ran into your project which is very
>> similar to (yet better than) one of my own ideas. So I thought "why
>> should I put time on inventing wet water instead of joining the
>> project?",
>>
>> On your homepage you stated that you have a lot of ideas but you don't
>> have the time to implement them all. My question is, do you have any
>> ideas that would fit to be done as a masters thesis in communication
>> networks? It could be anything from an issue related to the protocol
>> itself or it could be porting an already deployed technology on other
>> types of networks to the B.A.T.M.A.N. (I'm not suggesting anything,
>> but as an example let's say potential issues with live streaming over
>> a B.A.T.M.A.N.-network), comparing B.A.T.M.A.N. some other routing
>> protocol/s or any other topic related to my major subject. I really
>> don't have any idea on what problems you have encountered so please
>> help me find a good topic for my masters thesis.
>>
>> The thesis will be done during this summer.
>>
>> Thank you in advance
>> Vojislav Marinkovic
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@open-mesh.net
>> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>>
>>   
> 
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> 

--------------ms020906060302080104030509
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIR2DCC
BeIwggPKoAMCAQICAke1MA0GCSqGSIb3DQEBBQUAMFQxFDASBgNVBAoTC0NBY2VydCBJbmMu
MR4wHAYDVQQLExVodHRwOi8vd3d3LkNBY2VydC5vcmcxHDAaBgNVBAMTE0NBY2VydCBDbGFz
cyAzIFJvb3QwHhcNMDgwMzE0MTIwMDA0WhcNMTAwMzE0MTIwMDA0WjCBuzEUMBIGA1UEAxML
TWFpayBXb2RhcnoxHzAdBgkqhkiG9w0BCQEWEG1haWtAd29kYXJ6Lm5hbWUxITAfBgkqhkiG
9w0BCQEWEm1haWsud29kYXJ6QGdteC5kZTEpMCcGCSqGSIb3DQEJARYabWFpay53b2RhcnpA
aGF3LWhhbWJ1cmcuZGUxNDAyBgkqhkiG9w0BCQEWJW1haWsud29kYXJ6QGluZm9ybWF0aWsu
aGF3LWhhbWJ1cmcuZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC/Vt79Mh93
n36C9pk9JxInwAha6ZX541irQMh4Yxgdyt2nYyKghGykqT5+MYF7UYxcZHLjpCUyS7UcuSWG
JknaxBLMUpakuZSYRX5UoaxTReGyFPNQuwtX8+st1F8YmUXzGmHYWtfCZdUc608LBv8Ftip0
WllHFr+oe+c7+Jdl6ULD6w+7JnpAJX/vSvGPCl2Gp5mbL3b28OSBmS1W3zxf+xfwT0OPXURb
ZK+DcpzauD1Fn0n8KDIvi86IJMfn54OMrPi9FL904hK3bVcOIFA8q89XNXl6lyfK6PFJIprT
gB2Tm6WlU62oawe2Ok2nrWbSPx9MOH8y+VA/seH6tTXVAgMBAAGjggFUMIIBUDAMBgNVHRMB
Af8EAjAAMFYGCWCGSAGG+EIBDQRJFkdUbyBnZXQgeW91ciBvd24gY2VydGlmaWNhdGUgZm9y
IEZSRUUgaGVhZCBvdmVyIHRvIGh0dHA6Ly93d3cuQ0FjZXJ0Lm9yZzBABgNVHSUEOTA3Bggr
BgEFBQcDBAYIKwYBBQUHAwIGCisGAQQBgjcKAwQGCisGAQQBgjcKAwMGCWCGSAGG+EIEATAy
BggrBgEFBQcBAQQmMCQwIgYIKwYBBQUHMAGGFmh0dHA6Ly9vY3NwLmNhY2VydC5vcmcwcgYD
VR0RBGswaYEQbWFpa0B3b2RhcnoubmFtZYESbWFpay53b2RhcnpAZ214LmRlgRptYWlrLndv
ZGFyekBoYXctaGFtYnVyZy5kZYElbWFpay53b2RhcnpAaW5mb3JtYXRpay5oYXctaGFtYnVy
Zy5kZTANBgkqhkiG9w0BAQUFAAOCAgEAEGzGpRk6ez9ZybagXxQszW5tjAhg+zHOQSWlbW87
YCkIaHhQXlRcZ59xlsLVQ+Mp5mVCAc6/MlNcJCDY+hfIflE0jpXMM4/U566C8RkidmhCrmLC
UMVGCsA6edAM21TEHT0ZcNiMGpWUl0pFEIBm9XjIRzcfAvqsAtdW/t9Sw08FCwy/bS8al2mm
VMFkf2rwnCs3uh5UMjU6/9xKwtYUaIS3eieHS4cv9zTzYRjuCtFFcZ5WAeCnjDteW+Q/GJGy
RCEwIl9YEJfZuzDn9ERjqI+yA6XuSjoWhYHWd0nwH0M24Brt+Bkci3duLC+SMTkkekGMZatb
isH/1U/v4VMJ5HPmRVKEuocLW2ZZ8bK8zRNWElIwdO7+cP64EYVfnbNOirrGuvSvi6K3hw9c
HponHHYYlaeCib2zyH8x8JDV276ORK+YHGB7HD8+ZwgO9LNQK10sKCKfn/l1Ubpo4ea9hT0A
6CWOCRasMwf3Q15mKYTJRYsg9YHIiWxTPZ2m3CQENzWAZfp9cFVkz+0IRNRBZg15edfteZwa
Z9AzlWB1v/wwnMShsaRTNZGKio2Edaz8/YDfdOWtwJLg3ylQkXaoKGhGIe3Z1q4Mc4dZ74Sa
IpwhVgFkD001cr2ocuKOpGWJlUhJbpda3YrjxiwDsC8ScfLmuOfvqqBw7dWXIvIb/TYwggXi
MIIDyqADAgECAgJHtTANBgkqhkiG9w0BAQUFADBUMRQwEgYDVQQKEwtDQWNlcnQgSW5jLjEe
MBwGA1UECxMVaHR0cDovL3d3dy5DQWNlcnQub3JnMRwwGgYDVQQDExNDQWNlcnQgQ2xhc3Mg
MyBSb290MB4XDTA4MDMxNDEyMDAwNFoXDTEwMDMxNDEyMDAwNFowgbsxFDASBgNVBAMTC01h
aWsgV29kYXJ6MR8wHQYJKoZIhvcNAQkBFhBtYWlrQHdvZGFyei5uYW1lMSEwHwYJKoZIhvcN
AQkBFhJtYWlrLndvZGFyekBnbXguZGUxKTAnBgkqhkiG9w0BCQEWGm1haWsud29kYXJ6QGhh
dy1oYW1idXJnLmRlMTQwMgYJKoZIhvcNAQkBFiVtYWlrLndvZGFyekBpbmZvcm1hdGlrLmhh
dy1oYW1idXJnLmRlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAv1be/TIfd59+
gvaZPScSJ8AIWumV+eNYq0DIeGMYHcrdp2MioIRspKk+fjGBe1GMXGRy46QlMku1HLklhiZJ
2sQSzFKWpLmUmEV+VKGsU0XhshTzULsLV/PrLdRfGJlF8xph2FrXwmXVHOtPCwb/BbYqdFpZ
Rxa/qHvnO/iXZelCw+sPuyZ6QCV/70rxjwpdhqeZmy929vDkgZktVt88X/sX8E9Dj11EW2Sv
g3Kc2rg9RZ9J/CgyL4vOiCTH5+eDjKz4vRS/dOISt21XDiBQPKvPVzV5epcnyujxSSKa04Ad
k5ulpVOtqGsHtjpNp61m0j8fTDh/MvlQP7Hh+rU11QIDAQABo4IBVDCCAVAwDAYDVR0TAQH/
BAIwADBWBglghkgBhvhCAQ0ESRZHVG8gZ2V0IHlvdXIgb3duIGNlcnRpZmljYXRlIGZvciBG
UkVFIGhlYWQgb3ZlciB0byBodHRwOi8vd3d3LkNBY2VydC5vcmcwQAYDVR0lBDkwNwYIKwYB
BQUHAwQGCCsGAQUFBwMCBgorBgEEAYI3CgMEBgorBgEEAYI3CgMDBglghkgBhvhCBAEwMgYI
KwYBBQUHAQEEJjAkMCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5jYWNlcnQub3JnMHIGA1Ud
EQRrMGmBEG1haWtAd29kYXJ6Lm5hbWWBEm1haWsud29kYXJ6QGdteC5kZYEabWFpay53b2Rh
cnpAaGF3LWhhbWJ1cmcuZGWBJW1haWsud29kYXJ6QGluZm9ybWF0aWsuaGF3LWhhbWJ1cmcu
ZGUwDQYJKoZIhvcNAQEFBQADggIBABBsxqUZOns/Wcm2oF8ULM1ubYwIYPsxzkElpW1vO2Ap
CGh4UF5UXGefcZbC1UPjKeZlQgHOvzJTXCQg2PoXyH5RNI6VzDOP1OeugvEZInZoQq5iwlDF
RgrAOnnQDNtUxB09GXDYjBqVlJdKRRCAZvV4yEc3HwL6rALXVv7fUsNPBQsMv20vGpdpplTB
ZH9q8JwrN7oeVDI1Ov/cSsLWFGiEt3onh0uHL/c082EY7grRRXGeVgHgp4w7XlvkPxiRskQh
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
OhDzunDcAwBOPhl6Vpk4XhRj1AAAAAAAAA==
--------------ms020906060302080104030509--
