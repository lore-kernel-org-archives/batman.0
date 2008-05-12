Mime-Version: 1.0 (Apple Message framework v752.2)
In-Reply-To: <200805081812.33117.lindner_marek@yahoo.de>
References: <51B22798-78A8-4425-BAEA-530297B1518A@cslab.ece.ntua.gr>
	<200805081723.37648.lindner_marek@yahoo.de>
	<4822C548.40603@leo34.net>
	<200805081812.33117.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CB4F1B6A-15D9-4CFD-BA29-4B6AC6F72596@cslab.ece.ntua.gr>
Content-Transfer-Encoding: 7bit
From: Antony Chazapis <chazapis@cslab.ece.ntua.gr>
Subject: Re: [B.A.T.M.A.N.] 0.3 final <-> quagga
Date: Tue, 13 May 2008 01:26:42 +0300
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

I got some news.

I went the other way round and started out on an external program that
will act as an interface between batman and quagga. You can find it  
here:

http://www.cslab.ece.ntua.gr/~chazapis/batman/batquagga-0.1.c

It is more of a sketch-of-proof right now and _should not be used for
deployment purposes_. The program is completely based on the
libraries provided by quagga, in contrast to the current patch and
the olsrd plug-in, that re-implement the API.

Assuming you have quagga installed, you can compile it with:

gcc -o batquagga batquagga.c -lzebra

Some systems may also require "-lcap" linked in.

What batquagga does is read from standard input the ROUTE commands
issued by batmand (--policy-routing-script) and issue the corresponding
route add/del messages to zebra. Note that I read 11 variables form  
stdin,
which includes the "metric". So to use batquagga, you must have a batman
sources patched with the "...quagga.patch".

Moreover, batquagga can send redistribute requests to zebra, to
get routes by other protocols. For now, it just prints out the  
routes, but
as you said it should be easy to invoke batmand from within the program
to add/del HNAs.

Now to the problem:

When exiting, I tell zebra to give me back the routes marked as "batman"
through a redistribute request. The purpose is to clear all batman- 
originated
routes from the system. But zebra responds to a redistribute request  
only
with the "selected" routes. So some entries are not echoed back.

After various hacks, I conclude that in order to properly implement  
batquagga
I will either have to implement route-flushing in zebra, or I will  
somehow have to
change batmand so that it will clear all HNAs on shutdown. The first  
case
is easier and I will be trying to do that for now, but I guess the  
second is "better".

Which leads me to a question to developers:

Do you keep or plan to keep network HNA information in batmand?
I mean, is there any way that flush_routes_rules (in linux/route.c)  
could
be implemented in batmand, without the need of the external routing
table management?

As a routing daemon, batman, should keep track of the network state  
in its
own structures, which in turn would ease porting to other platforms  
as well.
As implemented, flush_routes_rules could be used for linux-specific  
clean-up
on startup. Another function, completely os-agnostic, could be  
implemented to
remove all batman-generated routes on shutdown. This is at least how all
quagga protocols are implemented.

Are there any plans on that?

Antony

(The batquagga name is credit of Acinonyx.)

On May 8, 2008, at 1:12 PM, Marek Lindner wrote:

>
>> Its a batman plugin like an olsr plugin. zebra doesnt provide any
>> plugins imo.
>>
>> You provide a external switch to insert HNA by script. Unfortunately,
>> zebra cant call external script as i have to patch zebra then - or i
>> dont know how.
>>
>> with the olsr-quagga-plugin i can redistribute zebra routes to olsr
>> internally. thats something i like to see with batman-zebra-plugin.
>
> Batman does not provide any plugin interface as well. Simply  
> because it is a
> routing daemon and should only do that. On the other hand we don't  
> like this
> rewriting of plugins over and over again.
> As already explained in the other part of this thread batman offers an
> external interface for adding/deleting routing information which  
> could be
> used for that. A little external application can talk to zebra, add/ 
> delete
> routes and/or HNA and could be _reused_ by other routing applications.
>
> Greetings,
> Marek
>
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

