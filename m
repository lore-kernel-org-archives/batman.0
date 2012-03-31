Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <BBFA727B-FECF-4C04-BCD1-3C76CBD010DE@gmail.com>
References: <CAA_JP8X+vPn39-QK-zPjdd1Mtn4PCTjigpV4fFM6sTVUmBiLTg@mail.gmail.com>
	<CAHD-aqKN_+5fwg65Udpr6jxt5tFsu5XXsMWkk75ujPK3bJcqJw@mail.gmail.com>
	<CAA_JP8UxNW18xWZe62ySY=H27HDnZY1YBQV-7ZGUHYnSS-ZSHw@mail.gmail.com>
	<CAHD-aqK_CGbc8u5GuEBJyFzrk2rTHHTw=bAiWjFafAW9xOqWiw@mail.gmail.com>
	<BBFA727B-FECF-4C04-BCD1-3C76CBD010DE@gmail.com>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Sat, 31 Mar 2012 15:11:47 -0300
Message-ID: <CAHD-aqLOLFq5LOYa94BffAzzD2uMSeKOtwaa_PG1+d8E2vrriw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] link alternation when radios are not on
	batman-adv router?
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Sat, Mar 31, 2012 at 12:45 PM, Dan Denson <dandenson@gmail.com> wrote:
> =C2=A0I think I understand. Basically, so long as two interfaces both hav=
e a path the to destination of acceptable quality, it will send the packets=
 out the interface that did not receive the packets. Hop count doesn't have=
 a direct effect, we don't really care about hop count, only about link qua=
lity.
>
> Is that the case?
>
>
> If hop count doesn't really matter, how do I identify my high quality, hi=
gh capacity backhauls?

In batworld, by their high TQ (=3D AFAIU lack of packet loss to destination=
.)
no capacity involved in the calculations.

(but devs might correct me if i'm being too shortsighted!)
