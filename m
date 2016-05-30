Return-Path: <patrick.d.bosch@googlemail.com>
MIME-Version: 1.0
In-Reply-To: <1623525.LPZfOt2ObD@prime>
References: <mailman.211.1463472563.23655.b.a.t.m.a.n@lists.open-mesh.org>
 <1623525.LPZfOt2ObD@prime>
Date: Mon, 30 May 2016 16:14:34 +0200
Message-ID: <CACJ=Ga=pJ5C9tpzDzXTNpKA61V2jYKmBJ0wY5adEBdBg0qB52w@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] How to read batadv-vis jsondoc correctly
From: Patrick Bosch <patrick.d.bosch@googlemail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Simon

Thanks for the reply!

Is there any way to find out which neighbours are used to reach
distant neighbours? Does any of the other visualisation outputs offer
this information? Or is it possible through batctl? This information
would be useful to me to correlate some tests as I'm expecting a lot
of changes in the topology. Anything would be helpful.

Kind regards
Patrick

On 27 May 2016 at 13:57, Simon Wunderlich <sw@simonwunderlich.de> wrote:
> Hi Patrick,
>
> sorry for the late reply.
>
> On Tuesday 17 May 2016 10:09:27 Patrick Bosch via B.A.T.M.A.N wrote:
>> Hi all
>>
>> As the title suggest, I'm wondering how to read the jsondoc output
>> correctly. It seems that every possible link is included in that
>> output, but which one is the one that is used? If there is one link,
>> it should be the one with the lowest metric, but what if a node has
>> more than one link?
>>
>> For example the following setup:
>>
>> Node 1
>>      |
>>      |
>> Node 2 ------- Node 3
>>
>> Here, node two would have two links. Now, if there would be some more
>> nodes that are in the jsondoc output, how can I find out which are the
>> links that are in use?
>
> The nodes which appear in the jsondoc are only originators which batman-adv
> decided to reach directly (with one hop) - so these are direct neighbors.
>
> Basically, all of these links would be in use from one node to its neighbor,
> so all of them are "in use". But you can't find out how much a link is
> actually used (i.e. how many packets/bytes are transmitted), or which neighbor
> is used to reach a distant neighbor.
>
> Cheers,
>      Simon
