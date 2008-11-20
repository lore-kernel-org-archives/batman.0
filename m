Message-ID: <53427.149.5.32.200.1227179161.squirrel@www.rivertowermail.com>
In-Reply-To: <200811201819.17453.lindner_marek@yahoo.de>
References: <52133.149.5.32.200.1227140000.squirrel@www.rivertowermail.com>
	<200811201148.45976.lindner_marek@yahoo.de>
	<49111.149.5.32.200.1227173227.squirrel@www.rivertowermail.com>
	<200811201819.17453.lindner_marek@yahoo.de>
Date: Thu, 20 Nov 2008 11:06:01 -0000 (UTC)
Subject: Re: [B.A.T.M.A.N.] My proposed network - is it ok?
From: "Derek C" <derekbatman@hssl.ie>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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
Cc: b.a.t.m.a.n@open-mesh.net

Hi Marek,

Yes - I did read about the default route remaining fixing somehow - I
suppose I didn't quite believe it!

I thought that the idea of keeping the network internal all the way to the
single point where I hit the Internet was the best idea.  I just have to
make sure I build multiple backbone links for resilience - I've got one
link up and I'll get another one up in the next two weeks and hopefully
thats a good start.

Derek


On Thu, November 20, 2008 10:19 am, Marek Lindner wrote:
> On Thursday 20 November 2008 17:27:07 Derek C wrote:
>
>> Overall that's great news (that I can route BATMAN over ethernet as
>> well as wireless) - it means that if routes flap from gateway to gateway
>> for whatever reason people will not drop connections as I'll keep the
>> NAT at
>> the Internet source (I can do it because I only have one Internet
>> source).
>
> Glad that you found your way through. I'm not so sure what route flapping
> you are talking about. Batman itself will keep an eye on the default route
> to ensure it does not change too often.
>
> Regards,
> Marek
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>


-- 
Derek C

