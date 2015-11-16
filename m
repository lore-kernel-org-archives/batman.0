Return-Path: <trizonelabs@gmail.com>
MIME-Version: 1.0
Date: Mon, 16 Nov 2015 23:00:59 +0200
Message-ID: <CAJuY50zf45s0Tst+2R4NtciE22kRqONJUUJAADA_7TvMH47XdQ@mail.gmail.com>
From: 3zl Trizonelabs <trizonelabs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Classes and purposed classes (problem to solve)
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

2015-11-16 4:13 GMT+02:00 Marek Lindner <mareklindner@neomailbox.ch>:
> On Saturday, November 14, 2015 20:04:49 3zl Trizonelabs wrote:
>> With multi-gateway there it seems the general problems how to
>> influence the batman-adv gateway announcement in respect of gateway
>> capabilities.
>
> Can you explain in greater detail what you are trying to achieve ?
>
>
>> Additionally we encountered the problem that a gateway lost uptream
>> connection(internet) without switching itself from server to client,
>> so nodes with path to that gateway routes their resp.clients to a
>> "black hole".
>> Question is how generally control the batman-adv routing in those cases.
>
> If you control the gateways the gateway should detect the uplink failure and
> stop announcing themselves as gateway. That is how most people are doing it.
>
in cases of gateway-router instabilites (short brownouts / blackouts )
 which we have alot with thunderstorms, it would be helpful if some
other control instance could block the gateway to be used inside the
batman-adv routing aside from the gateway anouncing itself.

> If you don't control the gateways or wish to solve this on the clients the
> batman-adv module would need to get extended to influence the selected gateway
> from user space.

Is there any idea how to implement some kind of  'control instance'
for the batman-adv routing ?

That also would help to achive some dynamic routing to gateways by
adjusting the qualtiy of those in respect L3 parameters.

tnx 3zl
