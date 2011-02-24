Return-Path: <hlabishik@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20101220090502.GA30598@Sellars>
References: <mailman.14.1290812292.944.b.a.t.m.a.n@lists.open-mesh.org>
	<AANLkTimR7VU95r3C-=C9rn5ftZahKkNTu3-cU-Vft+VZ@mail.gmail.com>
	<AANLkTikZJn5T7gEc_REH_vyEwhKhTcsqLRdq8tX0OdF8@mail.gmail.com>
	<AANLkTinFgQ+Z4OsvyHTMNhy11=SrEz0Xu+YU2iZcdcwZ@mail.gmail.com>
	<AANLkTimYtBa3fD_YNmFV2x0GUoyNiDzT47wy9Kuok0k9@mail.gmail.com>
	<AANLkTi=0tLPwa0toe9HX=PwA780mXTox8NrGNxymuF_-@mail.gmail.com>
	<20101220090502.GA30598@Sellars>
Date: Thu, 24 Feb 2011 11:58:02 +0200
Message-ID: <AANLkTi=7es_PbdB+-_+pGZ7B1n2Ke8xFUXRA7vFdP_O-@mail.gmail.com>
From: hlabishi kobo <hlabishik@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] BATMAN routing
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
To: =?ISO-8859-1?Q?Linus_L=FCssing?= <linus.luessing@web.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

HI everyone

Its been a while, I have been trying to test the weighted algorithm
(debugging and changing). I made changes on the method
bit_packet_count or rather replaced it with a method
weighted_bit_packet_count on which i try to count the number of
received OGMs received in a sliding window and giving them weights.
However when i test, i cant seem to ping other nodes to verify
connectivity (i first try on only two nodes). I have trying this and i
do not know i might have went wrong. see the code below.

int weighted_bit_packet_count(TYPE_OF_WORD *seq_bits)
{
	int i, count =3D 0;
	TYPE_OF_WORD word;

	for (i =3D 0; i < NUM_WORDS; i++) {
		//word =3D seq_bits[i];
	=09
		if (seq_bits[i] =3D=3D 1)
			count +=3D i;	=09
	}
	return count;

}

Kind Regards
Hlabishi

On 12/20/10, Linus L=FCssing <linus.luessing@web.de> wrote:
> Hi everyone,
>
> just wanted to share a website I found, which is actually for
> stock markets and their charts, but I think the Moving Average of
> a data set, that's what we'd have in common. And I guess what the
> economists have discovered and thought being useful could be
> useful for us, too. There are some nice and easy to understand
> articles here that explain the pros and cons:
>
> http://www.investopedia.com/university/
>
> Dictionary:
> - Simple Moving Average: http://www.investopedia.com/terms/s/sma.asp
>   (what we have now)
> - Weighted Moving Average:
>   http://www.investopedia.com/terms/l/linearlyweightedmovingaverage.asp
>   (Hlabishi's proposal)
> - Exponential Moving Average:
>   http://www.investopedia.com/terms/e/ema.asp
> - Double Exponential Moving Average:
>   http://www.investopedia.com/terms/d/double-exponential-moving-average.a=
sp
>
> Articles:
> - Weighted Moving Average:
>   http://www.investopedia.com/articles/technical/060401.asp
> - Simple vs. Exponential Moving Average:
>
> http://www.investopedia.com/articles/trading/10/simple-exponential-moving=
-averages-compare.asp
> - Double Exponential Moving Averages Explained:
>
> http://www.investopedia.com/articles/trading/10/double-exponential-moving=
-average.asp
> - Moving Averages:
>   http://www.investopedia.com/university/movingaverage/default.asp
>
> Cheers, Linus
>
