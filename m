Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 5 May 2011 09:05:18 +0200
References: <1304550695-6922-1-git-send-email-ordex@autistici.org>
	<1304577807-16450-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1304577807-16450-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4500575.roVkArVDgK";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105050905.20271.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batctl: rename stuff from *hna* to
	*tt* (translation table)
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
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart4500575.roVkArVDgK
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> diff --git a/packet.h b/packet.h
> index e757187..c225c3a 100644
> --- a/packet.h
> +++ b/packet.h
> @@ -61,7 +61,7 @@ struct batman_packet {
>  	uint8_t  orig[6];
>  	uint8_t  prev_sender[6];
>  	uint8_t  ttl;
> -	uint8_t  num_hna;
> +	uint8_t  num_tt;
>  	uint8_t  gw_flags;  /* flags related to gateway class */
>  	uint8_t  align;
>  } __packed;

Modified stuff in batctl/packet.h must also be changed in batman-adv/packet=
=2Eh=20
at the same time.

Kind regards,
	Sven

--nextPart4500575.roVkArVDgK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNwkwuAAoJEF2HCgfBJntGwioP/1CTSQz8aU25RzeoeWnqywzL
5EOJgeI7HsTdFCIWXuDIJwLF3sjBDnZai9TXwPUxWq3moZKD6Jt5YntAXrNmyizZ
cqNMF/hEQchxbCKnKq2kewhU/IGmkrqcwq49VQP5UeoeIsPR0IO3eIFHVJC9s17T
WXXR/NbL5Mg5fy84Gn+6BDeGmqAWOd76UBoeFQxoNsTihxqqUVV5gybcuet9LTbh
M8N7CekDpCK1VKr/vdk1TAM4pB2hj4W1oV2t+mMn0IQ1IhD0mKXmMb4symjo/+F1
4MjZX6/x7A8n/eBZlsC71qJ8nDcHmOBWXZPIHk/aU3GRQVtilCaE6MactFoksbEz
kuPIwDCDekUFFOqVPb7uskfHGIV+b4RWG9LMfLELNv3xAKQ+gCviS9rziISb5FP4
rWiN0PLFq89ime6NMM4MpL57OfLmaBxgfpbC8PGIvHP0q3i1s1BacL/yWOgANinh
WnfinYOgCR3XmThTn12jVPDbdYZ5LfE8At3/hPGu4Z/RpvwYWGxmGFOxeKrUB8Sa
hKTbkckw9307aqcZbeGZ3T579kvRJLMZN4L2lIlI9TF9IItBx1egI5YJ+3+hEQHe
CNtTtiHKbS1TLXgbjDPaxgnSYkrQUz9SQx4T8g622HAHMfg6HM/RkWio8aTbK9WM
NF2M+n78WRUKYn9GhT7y
=UkjK
-----END PGP SIGNATURE-----

--nextPart4500575.roVkArVDgK--
