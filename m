Return-Path: <mail@andreas-ziegler.de>
References: <20180602152635.2923-1-sven@narfation.org>
From: Andreas Ziegler <dev@andreas-ziegler.de>
Message-ID: <cb2c4d48-c57f-a455-174d-1a42369da0d8@andreas-ziegler.de>
Date: Sun, 3 Jun 2018 15:02:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180602152635.2923-1-sven@narfation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms090000030308070906080408"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: Fix bat_ogm_iv
 best gw refcnt after netlink dump
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

This is a cryptographically signed message in MIME format.

--------------ms090000030308070906080408
Content-Type: text/plain; charset=windows-1252
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Tested-by: Andreas Ziegler <dev@andreas-ziegler.de>

Sven Eckelmann schrieb am 02.06.2018 um 17:26:
> A reference to the best gateway is taken when the list of gateways in t=
he
> mesh is sent via netlink. This is necessary to check whether the curren=
tly
> dumped entry is the currently selected gateway or not. This information=
 is
> then transferred as flag BATADV_ATTR_FLAG_BEST.
>=20
> After the comparison of the current entry is done,
> batadv_iv_gw_dump_entry() has to decrease the reference counter again.
> Otherwise the reference will be held and thus prevents a proper shutdow=
n of
> the batman-adv interfaces (and some of the interfaces enslaved in it).
>=20
> Fixes: fa3228924152 ("batman-adv: add B.A.T.M.A.N. IV bat_gw_dump imple=
mentations")
> Reported-by: Andreas Ziegler <github@andreas-ziegler.de>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Cc: Andreas Ziegler <github@andreas-ziegler.de>
>=20
>  net/batman-adv/bat_iv_ogm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
> index be09a988..73bf6a93 100644
> --- a/net/batman-adv/bat_iv_ogm.c
> +++ b/net/batman-adv/bat_iv_ogm.c
> @@ -2732,7 +2732,7 @@ static int batadv_iv_gw_dump_entry(struct sk_buff=
 *msg, u32 portid, u32 seq,
>  {
>  	struct batadv_neigh_ifinfo *router_ifinfo =3D NULL;
>  	struct batadv_neigh_node *router;
> -	struct batadv_gw_node *curr_gw;
> +	struct batadv_gw_node *curr_gw =3D NULL;
>  	int ret =3D 0;
>  	void *hdr;
> =20
> @@ -2780,6 +2780,8 @@ static int batadv_iv_gw_dump_entry(struct sk_buff=
 *msg, u32 portid, u32 seq,
>  	ret =3D 0;
> =20
>  out:
> +	if (curr_gw)
> +		batadv_gw_node_put(curr_gw);
>  	if (router_ifinfo)
>  		batadv_neigh_ifinfo_put(router_ifinfo);
>  	if (router)
>=20


--------------ms090000030308070906080408
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
CyswggU9MIIEJaADAgECAhA5K+eaTeV04/PDCzICzZF7MA0GCSqGSIb3DQEBCwUAMIGXMQsw
CQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxm
b3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBD
bGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0xODAyMjMwMDAw
MDBaFw0yMTAyMjIyMzU5NTlaMEIxGDAWBgNVBAMTD0FuZHJlYXMgWmllZ2xlcjEmMCQGCSqG
SIb3DQEJARYXbWFpbEBhbmRyZWFzLXppZWdsZXIuZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQDaHX0YTSleiiHpHyZPeU7fPIdS0wBmnSYzXbxkHVSuh2I+iIwUr7HtFscN
6WreuQlQ5oKk+VVgIs9AbtnZfUfB8tM6H67Khq+RQJWHY41I+6ZmCPhIAeaXAOvIkBX0C1TT
N1OZoQOlRsuOXj6/VxlnSz5zeprP4CQ3HuvSy++mvgJhhtqbZMOe3iRRi/yNlldu+/PSWZHj
mSw4J8WnC1eUksZAnc2nmtDmD3Iht5ajQ9aCjIOZy91q50ApJ4ItwRo/8Y+Nmv0LZre0Bm/B
Q50ctgm3zUf6u80/jH1FoNmNh92fvD8sdX7UJ3ZRowf6WfvzLSDqWiTf1uIhm4COCLH7AgMB
AAGjggHXMIIB0zAfBgNVHSMEGDAWgBSCr2yM+MX+lmF86B89K3FIXsSLwDAdBgNVHQ4EFgQU
eVk7Ta0AcqcbMGRS8q7OhzlW3vIwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYD
VR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMEYGA1UdIAQ/MD0wOwYMKwYBBAGyMQECAQMF
MCswKQYIKwYBBQUHAgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5uZXQvQ1BTMFoGA1UdHwRT
MFEwT6BNoEuGSWh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVudEF1dGhl
bnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYsGCCsGAQUFBwEBBH8wfTBVBggrBgEF
BQcwAoZJaHR0cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGlj
YXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29t
b2RvY2EuY29tMCIGA1UdEQQbMBmBF21haWxAYW5kcmVhcy16aWVnbGVyLmRlMA0GCSqGSIb3
DQEBCwUAA4IBAQCFJVypS8gqRM0t0g78L04QmmhTzBUnO986evvic82RvjC+PNNQQA3kLzMb
vWNkfYgaHJ7mGnlqyeD3Nlq6yJGSecKqyS9rJ9AKjFwQoHl7Oa35bpuvJGAFLfB+qE0Eggyf
lOGb/sRmGnNNfzcQRJE20hEwEzrhxQyGQbFwTkin8UraVOkRaJU+gKF8h1raoo5dh5UAvFRE
hZCDdxNb/noR6iwuF9cvEkzckirzHSBSqUUBsOAkGakzDY1WDQ8j8AZ3/utSHCos2oDc+cHD
7BYoVFDW5CjNSO+y3PybrFfyQDHIZ0Tuz0e/azPjmtaNrBY/AqIOl1OzYHAgkMN0hrW+MIIF
5jCCA86gAwIBAgIQapvhODv/K2ufAdXZuKdSVjANBgkqhkiG9w0BAQwFADCBhTELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEa
MBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxKzApBgNVBAMTIkNPTU9ETyBSU0EgQ2VydGlm
aWNhdGlvbiBBdXRob3JpdHkwHhcNMTMwMTEwMDAwMDAwWhcNMjgwMTA5MjM1OTU5WjCBlzEL
MAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0Eg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwggEiMA0GCSqGSIb3
DQEBAQUAA4IBDwAwggEKAoIBAQC+s55XrCh2dUAWxzgDmNPGGHYhUPMleQtMtaDRfTpYPpyn
MS6n9jR22YRq2tA9NEjk6vW7rN/5sYFLIP1of3l0NKZ6fLWfF2VgJ5cijKYy/qlAckY1wgOk
UMgzKlWlVJGyK+UlNEQ1/5ErCsHq9x9aU/x1KwTdF/LCrT03Rl/FwFrf1XTCwa2QZYL55AqL
PikFlgqOtzk06kb2qvGlnHJvijjI03BOrNpo+kZGpcHsgyO1/u1OZTaOo8wvEU17VVeP1cHW
se9tGKTDyUGg2hJZjrqck39UIm/nKbpDSZ0JsMoIw/JtOOg0JC56VzQgBo7ictReTQE5LFLG
3yQK+xS1AgMBAAGjggE8MIIBODAfBgNVHSMEGDAWgBS7r34CPfqm8TyEjq3uOJjs2TIy1DAd
BgNVHQ4EFgQUgq9sjPjF/pZhfOgfPStxSF7Ei8AwDgYDVR0PAQH/BAQDAgGGMBIGA1UdEwEB
/wQIMAYBAf8CAQAwEQYDVR0gBAowCDAGBgRVHSAAMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6
Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3Js
MHEGCCsGAQUFBwEBBGUwYzA7BggrBgEFBQcwAoYvaHR0cDovL2NydC5jb21vZG9jYS5jb20v
Q09NT0RPUlNBQWRkVHJ1c3RDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9k
b2NhLmNvbTANBgkqhkiG9w0BAQwFAAOCAgEAeFyygSg0TzzuX1bOn5dW7I+iaxf28/ZJCAbU
2C81zd9A/tNx4+jsQgwRGiHjZrAYayZrrm78hOx7aEpkfNPQIHGG6Fvq3EzWf/Lvx7/hk6zS
PwIal9v5IkDcZoFD7f3iT7PdkHJY9B51csvU50rxpEg1OyOT8fk2zvvPBuM4qQNqbGWlnhMp
IMwpWZT89RY0wpJO+2V6eXEGGHsROs3njeP9DqqqAJaBa4wBeKOdGCWn1/Jp2oY6dyNmNppI
4ZNMUH4Tam85S1j6E95u4+1Nuru84OrMIzqvISE2HN/56ebTOWlcrurffade2022O/tUU1gb
4jfWCcyvB8czm12FgX/y/lRjmDbEA08QJNB2729Y+io1IYO3ztveBdvUCIYZojTq/OCR6Mvn
zS6X72HP0PRLRTiOSEmIDsS5N5w/8IW1Hva5hEFy6fDAfd9yI+O+IMMAj1KcL/Zo9jzJ16HO
5m60ttl1Enk8MQkz/W3JlHaeI5iKFn4UJu1/cP2YHXYPiWf2JyBzsLBrGk1II+3yL8aorYew
6CQvdVifC3HtwlSam9V1niiCfOBe2C12TdKGu05LWIA3ZkFcWJGaNXOZ6Ggyh/TqvXG5v7zm
EVDNXFnHn9tFpMpOUvxhcsjycBtH0dZ0WrNw6gH+HF8TIhCnH3+zzWuDN0Rk6h9KVkfKehIx
ggQ1MIIEMQIBATCBrDCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7
BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEDkr55pN5XTj88MLMgLNkXswDQYJYIZIAWUDBAIBBQCgggJZMBgGCSqGSIb3DQEJ
AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDYwMzEzMDIzOVowLwYJKoZIhvcN
AQkEMSIEIJqAeVXA6l0t0Pn8l9KzMP0UfoC67tlTg5rMIz2eB1fIMGwGCSqGSIb3DQEJDzFf
MF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgIC
AIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgb0GCSsGAQQBgjcQ
BDGBrzCBrDCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQ
MA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMT
NENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EC
EDkr55pN5XTj88MLMgLNkXswgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGXMQswCQYDVQQGEwJH
QjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYD
VQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0
aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQOSvnmk3ldOPzwwsyAs2RezANBgkq
hkiG9w0BAQEFAASCAQBTRfbgvTDzhfp89rB2N2cpVb65c3GREGSOOh9bUzKiX5ONApiJShLc
Pe7e68TATwLyU8sGioVWGDIKC5lKMCl/T278e0YvrLQX1GeHbb4E54ToAzESyJpL1O/XWZeV
J2mAC4kZEsQa/AsEeDXDcvZVy/Xhv4I7kxudI0UfFAgjsB+Le48x0WkPp8Z8gjxZ9UI5q1Ld
d3q1wsJLmNjvYQu8CvaSWPIcmdHHDaA/1M92znSqqshitTl3R4E0n2bsLaaDNwbnS9HU5c0o
Zy3EcZk26mF+ovVn9vKgT+/XWLANRz0bKY+TQrXbqVsgbKzmdvTvuWoz+tBAFjghjTtT89QM
AAAAAAAA
--------------ms090000030308070906080408--
