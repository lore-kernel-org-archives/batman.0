Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 2 Apr 2012 17:29:01 +0200
References: <CAA_JP8UrWSzLYoUEhrzbT1fjeedp28B0dr7dMB_TizLkr+4RNg@mail.gmail.com>
	<201204021132.42284.lindner_marek@yahoo.de>
	<CAA_JP8WrwQ52eVZsXRh1TcVqPGOq7kZAz1UqMbhLrOEDuuQZiA@mail.gmail.com>
In-Reply-To: <CAA_JP8WrwQ52eVZsXRh1TcVqPGOq7kZAz1UqMbhLrOEDuuQZiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201204021729.02256.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] any throughput mechanism or plans?
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

On Monday, April 02, 2012 15:35:35 dan wrote:
> > This will result in a metric optimizing paths for the highest throughput
> > ever recorded. In reality one can easily observe many links with
> > variable throughput. Sometimes you get a spike of high throughput
> > although the average speed is lower. Or your wifi environment changes
> > with a negative impact on the throughput.
> 
> True. maybe not keep the maximum.  Maybe watch the interface queue and
> measure the throughput when frames start to get queued.  Updated the
> 'max' speed whenever an interface starts to queue frames.

Watching the interface queue would be very interesting for other features as 
well but turns out to be hard in practice. A while ago Simon and others tried 
to improve the interface alternating / bonding by monitoring the fill status 
of the queue. But the wifi stack does not report the fill status. Even if it 
did we don't know what is going on in the hardware.

We still have the problem that some links might be idle, therefore we will 
have to generate traffic before we can evaluate these links.


> > Yes, we still have the "costly" way of detecting the link throughput
> > ourselves. What do you think about the idea of asking the wifi rate
> > algorithm for the link speed ?
> 
> I am a wisp.  In my experience, the wifi sync rate isn't reliable.  In
> perfect conditions yes, but when there is fresnel zone incursion on a
> wireless link, the algorythm can't take into account reflected signal
> as noise because they dont exist yet.  Not until you start transfering
> data does the signal get reflected back (as noise) and the radio has
> to adjust the rate down.  Problem is that this happens after you have
> dropped 5% of your packets, which would drop the TQ on the link and it
> would be effectively down until.  Now the data stops, reflections
> stop, link changes speed back up and very light use (pings, OGMs)
> travel safely and TQ rises. Rinse and repeat.

Sounds very similar to the problem above: Without traffic we can't be sure 
about the possible throughput.


> I wish I had a really great solution to this.  I dont really have
> anything to complain about, batman-adv is already a mile ahead of the
> next best mesh routing protocal :)

Thanks for the flowers!  :-)
Still, we have some work ahead of us. Throughput based routing is a hot topic 
we want to work on. All ideas are welcome.

Cheers,
Marek

