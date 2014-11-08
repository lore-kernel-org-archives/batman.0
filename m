Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 08 Nov 2014 18:32:59 +0800
Message-ID: <3080439.aqeQ0ndHhf@diderot>
In-Reply-To: <CAEbDFcQkyHHSMWcF2tMN_TfRTV3Or4GMScS0Mp=OovOKfZ4Rbg@mail.gmail.com>
References: <CAEbDFcSO2jVkSKwS5KirqNLmfT69X5jDA0qW_nP3KaZRkFnNuw@mail.gmail.com>
 <545CF861.2000304@meshcoding.com>
 <CAEbDFcQkyHHSMWcF2tMN_TfRTV3Or4GMScS0Mp=OovOKfZ4Rbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4033080.Ty1NHGBOUH";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Queues in batman-adv
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


--nextPart4033080.Ty1NHGBOUH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 08 November 2014 09:00:53 Krishnathiepan Rasanayagam wrote:
> Im aware that batman-adv doesn't care about tcp or udp and it doesn't
> have any queues either. what i want is how it handles the out going
> packets more specifically how it places the Frames on net. what file
> does this and what headers supports this?

Seems you are looking for some basics ? How about peeking into my preferred 
master thesis to point people to ? 

Network coding with batman-adv (linked and hosted on open-mesh.org). Chapter 4 
goes into details how frames travel through batman-adv:
http://downloads.open-mesh.org/batman/papers/batman-adv_network_coding.pdf

Probably not 100% accurate these days (batman-adv does change quite a bit) but 
it should help you to get the picture.


Cheers,
Marek

--nextPart4033080.Ty1NHGBOUH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUXfFgAAoJEFNVTo/uthzAt6oH/1HWCvVJOgrAHjKaenCHxCjn
EOSnQzvFCuHRCklc5jX0tCMG/hpylGev7q3VARCPn8pKqA7t039KsP8nnzacgs4L
C/otto1h0A+oKEZgJo1SDBDsOzMazixM4Xo5cnxeznPYAyqtXTajVBqmLRiooLi5
f/0GKD9S7A7X6LPHPuCvt1S2KfCXaG2JzoFUv72UdvKJNT/nCAivP9pY8kp7joM/
AV45A7tINZd6g6CqLtI6mUse1sAH9U33qfnwck5ZBh9wSdfamc8176fX60XC9prI
oNi19hMr4sOYIEKffUx5+7ipe4etbkC9PSXAuVNXpTOPIfNBfJ8pWzzBcDlWb8E=
=OrA6
-----END PGP SIGNATURE-----

--nextPart4033080.Ty1NHGBOUH--

