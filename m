Return-Path: <booray@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1463029.4iWUHdE7x7@prime>
References: <CAA51LVr2ogEGnJNCepYRm2eAZvE_TpPFTeLf6BXkVpjyFfHSFg@mail.gmail.com>
 <1463029.4iWUHdE7x7@prime>
Date: Tue, 12 Aug 2014 11:21:18 -0700
Message-ID: <CAA51LVpzYaMEkrsKwo2yXkMg9+zTtBtqGO7=96mB0Pyv+NSB6w@mail.gmail.com>
From: Ray Gibson <booray@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Testing example of interface bonding
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
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Simon,

Thank you for looking at this with me.

On Mon, Aug 11, 2014 at 2:38 PM, Simon Wunderlich <sw@simonwunderlich.de> wrote:

> Hmm. What you should see after enabling bonding would be a similar usage of
> both interfaces. I guess each tap interfaces of node1 is "directly connected"
> to  the other tap interface of node2, right? Could you please share your
> outputs of:

Yes, the tap interfaces behave as if they are directly connected together.

> batctl originators
> batctl originators -i tap0
> batctl originators -i tap1

I've put all the output in a pastebin as to not clog up everyone's inbox:

http://pastebin.com/6fqUUUYq

> Please note that the bonding will only benefit under some circumstances, as far
> as my experiments have shown:
>
>  * since its round robin, you'll only see a benefit if the worst link does not
> have less than 50% throughput of the best one - otherwise it will slow the
> other links down.
>  * different latencies or buffering delays in the links may lead to out of order
> packets, and not every payload traffic likes that.
>
> I could see some improvement when having two equal wifi links though. In any
> case, please thoroughly test it before applying that to your 3g/4g
> application, there may be some pitfalls. I'd be also very interested in your
> findings. :)
>
> Thanks,
>     Simon

Regardless of its potential impact on performance, I think it's worth
a look and test to see if there may be some potential benefit.
Currently this setup is working nice in that it's a true case of point
to point redundant links.  If additional links could be added or
removed at will to enhance throughput I would see this useful in a
variety of applications.  Currently, I'd like to just reproduce what
the function was originally designed to do and then go from there.

Thanks again for the help.

Ray
