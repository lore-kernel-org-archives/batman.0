From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 1 Jun 2009 18:44:11 +0200
References: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
	<200905291502.43117.lindner_marek@yahoo.de>
	<4313f3060905290700v55e0d724oa7357208d1491a15@mail.gmail.com>
In-Reply-To: <4313f3060905290700v55e0d724oa7357208d1491a15@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7498348.XtPqDGITxY";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200906011844.15664.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] [batman] Add padding around allocation
	debugger structures
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
To: b.a.t.m.a.n@open-mesh.net

--nextPart7498348.XtPqDGITxY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 29 May 2009 16:00:40 Nathan Wharton wrote:
> > @Nathan: Could you let me know if these patches work for you ? If so I'=
ll
> > commit them.
> >
> > Regards,
> > Marek
>
> I set /proc/cpu/alignment to 4 (raise bus error) and I get a bus error:
>
> Program received signal SIGBUS, Bus error.
> list_add_tail (new=3D0x29368, head=3D0x28819) at list-batman.c:68
> 68              __list_add( new, head->prev, (struct list_head *)head );
> (gdb) l
> 63       * Insert a new entry before the specified head.
> 64       * This is useful for implementing queues.
> 65       */
> 66      void list_add_tail( struct list_head *new, struct
> list_head_first *head ) {
> 67
> 68              __list_add( new, head->prev, (struct list_head *)head );
> 69
> 70              head->prev =3D new;
> 71
> 72      }
Have you added the patches per hand? At this moment no patch I've made=20
available in trunk. As you have run it with gdb, can you please append a fu=
ll=20
backtrace?

Best regards,
	Sven

--nextPart7498348.XtPqDGITxY
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAABCgAGBQJKJAVcAAoJEF2HCgfBJntG/V0QAMssIngqsOjVWgoe4BGGETK9
36jFlpEN/JNduBn0I9FJvSvr2VBTRzcs7XfeJoSi32htTfqUl7Fx0goLGhqDDJbk
ywgIRIgvnYKZij17fCN/9kePOmfNf3+6eHJ1f3SFrqHPLp/zClgdr+oIauiVh3mY
9BGmOXZFnWwSbp5TZ7+E/fgNtJBoLTCyy3ajMRQV39/hmhSYuamUK2aFjc+vEfqg
F10JyNDjOOE3m75T//2oWfcEM2zH6oMYFyAVrJ2emx1QhNdFJeEsrqL6+nSDdv4v
1B99bFI2nebJc9LlJ9aaSyCYwZ4T7TtzFBgyExO3/qWcu6aDy2QDnXhoW97gTJSM
xB3FFyNB8sSwyrPrPPjNYmVPnaV/fMHuTnHyOksYxQ7SFN7oV6O/Fe7qqEOrBLP4
lIOYTB+2m++nqYOdftFkrTP70MQ9njHi9D0fZ9zaM1dENjGj/QIBwqrCCbQs5jtZ
DNmDJpeFY92Q8KIx+Fgedh4kpJvV/kLtt+IeQ8gy3UXzhk7oiefRSBvUI3TS3lJD
JxTTmy60NYI1u9g5aglvUY0wJdilCACf1QeYVRxFDQQOmbaoyRQRsne1I2RWql6X
foYB/dL35+fnJOgubFCGxrhHiWziJQfgUxwCo55v4V7A5X23T5e5Ve1niyavNx5Y
dF+ZyFvDGIhpGNHTN6FW
=YTpV
-----END PGP SIGNATURE-----

--nextPart7498348.XtPqDGITxY--
