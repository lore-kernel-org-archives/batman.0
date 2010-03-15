Return-Path: <michaelfazio@me.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Message-id: <59537C95-BCEC-4E94-9E59-E0E96D289776@me.com>
From: Michael Fazio <michaelfazio@me.com>
In-reply-to: <20100314204138.GA6096@Linus-Debian>
Content-transfer-encoding: quoted-printable
Date: Mon, 15 Mar 2010 19:23:53 +0800
References: <8D692389-52C5-4CCB-BE58-D4B2E4D07161@me.com>
	<20100314204138.GA6096@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N Suitability for MAGIC 2010
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

Hi Linus (and others who responded),

									=
Well I don't remember mentioning MAGIC 2010, but you are =20
correct, the project is MAGIC 2010. Good investigatory work! :) Right =20=

now, the use of B.A.T.M.A.N, OLSR, and Babel are possibilities but no =20=

decision has been made regarding their eventual use.

The reason I was looking into these technologies is because of the =20
"seamlessness" of their operation and the fact they enable multi-hop =20
routing for IPv4 in ad-hoc network setups. The hidden node problem =20
could be a show stopper as some of the data we are transferring such =20
as streaming video and manual control of UGVs require relatively =20
stable and continuous channels of communication. Furthermore, message =20=

passing may not necessarily be done with the use of a middleware. =20
Realtime unreliable data such as GPS and telemetry information may =20
simply be pushed onto the network in UDP packets. I would prefer to =20
use a nice middleware that performs well in MANET environments and I =20
am still evaluating the possibility of this. If you have any =20
recommendations that would be good!

Further on the topic of using BSS. We do expect wifi dead-spots and we =20=

must absolutely try to minimize these. So the multi-hop nature of =20
something like B.A.T.M.A.N (i was hoping) would help in that regard.

I can't guarantee that we will use B.A.T.M.A.N but I will try to =20
evaluate it in the field eventually.

Thanks!

Michael

On 15/03/2010, at 4:41 AM, Linus L=FCssing wrote:

> Hi Michael,
>
>> My name is Michael. I am currently working on a large robotics
>> project and I am thinking of using B.A.T.M.A.N to facilitate a MANET
>> to communicate between a number of bots and a base station. I was
>> hoping to get a bit of information regarding the suitability of
>> B.A.T.M.A.N for such an application. Any information would be helpful
>> (general or specific). Here are some of the details of our project.
>
> Your project sounds very exciting! I had a little look at the MAGIC =20=

> 2010
> website and what it says about the tasks that have to be done and =20
> what kind of
> time span and how much mobility we're talking about here and what =20
> the specific
> tasks are on the MAGIC 2010 website. However, I/we have little =20
> experience with
> such challenges and setups. Most people use batman to create =20
> wireless networks
> within buildings / houses / cities. Could you tell us a bit more =20
> about why you
> want to run mesh on the robots itself and not using the common =20
> infrastucture
> mode on the base station for example (as I assume this has been used =20=

> in robotic
> challenges before)? Have other people tried mesh on bots before and =20=

> what were/are
> the problems you expect?
>
> So far, I haven't heard of anyone using B.A.T.M.A.N. in a robotics =20
> scenario
> before, though I've always been interested in seeing B.A.T.M.A.N. in a
> swarm-robotics scenario one day :).
>
>> We have various types of data to be communicated on our network
>> including, GPS, basic telemetry, control message, imagery, UAV feeds,
>> point cloud info etc.
>> Some data such as GPS and telemetry is realtime and need not be
>> reliable (we are considering simply UDP broadcasting this data). =20
>> Other
>> data such as imagery and control messages will require stable links
>> and need to be relatively reliable.
>> We are not yet sure if we will be deploying any specific middleware
>> technology although I am partial to pub/sub middleware. Are there any
>> such middleware that can complement B.A.T.M.A.N?
>
> 14 mobile bots should be perfectly fine for batman to handle. Like =20
> most routing
> protocols, batman does not interact with other software components =20
> directly.
> It will try to be as invisible as possible and allows all standard =20
> network
> operations to behave as expected. Nothing special or fancy required =20=

> here.
>
> On the other hand it is important to realize that batman comes in 2 =20=

> flavors:
> * The batman daemon operating on layer 3 (like most other routing =20
> protocols
> do).
> * The batman-adv kernel module building a layer 2 network across the =20=

> wifi
> nodes.
>
> The later comes with some handy features you might want to look at. =20=

> Unlike the
> layer 3 routing protocols it does not only decide about the routing =20=

> of the
> traffic but handles the traffic forwarding itself. Therefore, it can =20=

> be optimized
> for your traffic needs. For example, broadcasting UDP messages over =20=

> wifi is not
> as easy as it sounds (broadcasted packets are getting lost more =20
> often than unicast
> packets here). batman-adv already has a feature built-in to send =20
> broadcasts up to
> 3 times along each hop to increase the probability of getting the =20
> data transmitted.
>
>> I was hoping to know what type of issues I might run into using
>> B.A.T.M.A.N adv in such a scenario. For instance, what kind of
>> throughput might I expect in the described environment? Link =20
>> stability
>> issues? General suitability? How would B.A.T.M.A.N compare to OLSR or
>> Babel? I am really interested in anything that anyone has to offer.
>
> Usually in mesh networks the rule so far was, that you can expect =20
> about half
> of the bandwidth with each additional hop starting with ~25MBit/s =20
> payload
> throughput in 802.11a/g networks for direct neighbours. In 802.11n =20
> you can
> expect a maximum capacity of ~100MBit/s in ideal conditions with a =20
> wifi card
> capable of 3x3:3or 4x4:4 settings as far as I know.
> For QoS there seems to be the 802.11e standard especially for wifi =20
> networks,
> but I have no experiences with that one.
> I can't say that much for the protocol comparision as I haven't been
> using/testing current implementations of OLSR or BABEL lately and =20
> I'm also
> only aware of two comparison papers. I think it comes down to try =20
> what works
> best for you and what your requirements are.
>
> When you start your tests you might want to reduce the originator =20
> interval to
> 50ms (the minimum value) to make sure the routing entries are =20
> updated quite
> often. Batman's default settings are optimized for less traffic but =20=

> slower
> updates. Buildings tend to move much less. ;-)
>
> Hope I could answer most of your questions so far. More questions
> always welcome :).
>
> Cheers, Linus

