MIME-Version: 1.0
In-Reply-To: <20090212125347.GA4074@pandem0nium>
References: <238a15490902111906g23358005v35fd57d8df857154@mail.gmail.com>
	<20090212125347.GA4074@pandem0nium>
Date: Thu, 12 Feb 2009 08:58:31 -0600
Message-ID: <238a15490902120658h4edb144bvc17db63a5b4a6f0a@mail.gmail.com>
From: Gargi Purohit <gaargie@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Using batman L2 on multiple wireless cards
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

cool....i set it up that way...i have each of the cards on different
channels...so every board has ath0 and ath1 each tuned to a different
channel....

so some boards are reachable on channel X whereas others on channel Y

however when i check the /proc/net/batman-adv/originators....i see
that all other nodes are reachable but the interface mentioned is
ath1....(even those which are actually reachable by ath0)

shouldn't some of the boards be reachable by ath0 - as some nodes are
on a different channel...

or is it like ath1 is some main interface.....

On Thu, Feb 12, 2009 at 6:53 AM, Simon Wunderlich
<simon.wunderlich@s2003.tu-chemnitz.de> wrote:
> Hello Gargi,
>
> yep, thats exactly the way to go. :)
>
> best regards
>        Simon
>
> On Wed, Feb 11, 2009 at 09:06:46PM -0600, Gargi Purohit wrote:
>> Hi
>>
>> I was wondering if I can run L2 batman kernel module on hardware which
>> has 3 wireless cards.
>> Should be process be the same as in adding interfaces e.g. ath0, ath1,
>> ath2 to /proc/net/batman-adv/interfaces (where ath0, ath1, ath2 are
>> different wireless cards)
>> and adding bat0 with eth0 to the bridge?
>>
>> Regards
>>
>> Gargi
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@open-mesh.net
>> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.6 (GNU/Linux)
>
> iD8DBQFJlBvbrzg/fFk7axYRAtgKAKDu6Wnm=E3=A8=8D=E8=B7=BF=E4=87=B9=E1=BF=81=
=E3=AB=AF=EA=9D=A7=E5=A9=99=EA=8C=80=E2=9F=9B=EF=BF=BD
> dFuChjqLqYH/dXsbdAqH9vU=3D
> =3D/7Tb
> -----END PGP SIGNATURE-----
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>
