Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <201203261747.17373.lindner_marek@yahoo.de>
References: <CAHD-aqKv+7SDGC-07Or+xOZKiJATPmOy876SnDawJp_Zs0GZvg@mail.gmail.com>
	<201203261747.17373.lindner_marek@yahoo.de>
Date: Mon, 26 Mar 2012 13:23:57 -0300
Message-ID: <CAHD-aqLmGQwzK1u8vmgEwpbNTPMZuonJikjkT=uaOkcPedFptg@mail.gmail.com>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] BW degradation on p2p links?
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

Hey thanks marek! I'm sorry i didn't think of trying that in the first
place. Ath9k_htc has indeed a few issues so i wouldn't be suprised
it's the culprit.

I was aware of the battlemesh v5 and last week i even piperlurked the
mail archives, but didn't realize it would happen this week. Best luck
in athens then!
I will continue my little mesh-battle here.
Will try static routes tomorrow and report anything interesting.

Cheers,
guido

On 3/26/12, Marek Lindner <lindner_marek@yahoo.de> wrote:
>
> Hi,
>
>> i'm participating in the development of a wireless mesh network in
>> Delta de Tigre, near Buenos Aires, Argentina.
>> Landscape is absolutely flat, with dense forest 15-20mts tall. Nodes
>> are being installed along the river, 50 - 150mts apart, with clear LOS
>> at ground level.
>> I collaborated with Nico Echaniz last month, bulding another community
>> network in Cordoba, and given the success, I decided to start one more
>> here. I'm also really thankful with Elektra, for recommending the
>> tl-m3220 to Nico!
>> We chose batman over olsr, in part because of avahi stuff, but also to
>> have a real-world implementation and thus collaborate in testing /
>> debugging :) So far, there are  only 4 working nodes, but luckily I'm
>> already facing unexpected behaviour.
>>
>> I'm sorry for the long email, it's mostly terminal logs.
>> In short, iperf between two neighbouring nodes reports >20mbps, yet
>> running the same iperf between nodes separated by one hop reports
>> inexplicably low <5mbps.
>>
>> [..]
>>
>> Any ideas, thoughts, pointers? Any additional info needed?
>
> welcome on the list!
> I admit not having dived into all the details of your mail - the bigger part
> of the batman team is sitting in Athens at the moment (see battlemesh.org).
> The best next step is to find out whether this performance issue is a
> batman-
> adv or a wifi driver problem. May I suggest you remove batman-adv and repeat
> the same test using static routing ? If you still see the problem it is the
> wifi that is not working otherwise we have to fix batman-adv.
>
> Regards,
> Marek
>
>
