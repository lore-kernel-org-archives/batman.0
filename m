Return-Path: <dominicfollett@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1934520.YmdkrNAjpg@bentobox>
References: <CA+h5VgqB82br1u9Cdg423Eedd8m23wMO=PWo86q+TTAXVtuy8Q@mail.gmail.com>
 <16662960.TUJbz1tKdU@bentobox> <1934520.YmdkrNAjpg@bentobox>
Date: Thu, 4 Oct 2012 21:30:24 +0200
Message-ID: <CA+h5VgqcOikZGAGhw7Ztz+H6E8EtA39o0V-qFYxPGRv=d4ws=w@mail.gmail.com>
From: Dominic Follett-Smith <dominicfollett@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] mac address from packet
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi,

We have set up a 4x4 test bed composed of  Alix PC engines routers,
with debian 2.6.32 OS,  CM9 Atheros pci cards with ath5k driver. We
are using batmand, in this mesh.

We have set the txpower level to 0dBm to enforce mutli-hopping in the
testbed. We have the pci cards operating in ad-hoc mode.

What we are trying to do is use the physical interference model for a
new interference metric we have made. In order to do this, we need to
obtain the received signal strength of an OGM that a station has
received from a neighbour.

We initially thought that a simple method would be to use the iw tool
as follows:

iw dev wlan0 station get <mac address of neighbour station>

However we need the mac address of the neighbouring station that sent
the OGM. But we are not sure how to go about retrieving the mac
address which is part of the ethernet mac header at the beginning of
the frame.

I am happy to provide more details, if I have left anything out.

Kind Regards
Dominic

On Thu, Oct 4, 2012 at 6:32 PM, Sven Eckelmann <sven@narfation.org> wrote:
> On Thursday 04 October 2012 18:30:25 Sven Eckelmann wrote:
>> On Thursday 04 October 2012 18:21:02 Dominic Follett-Smith wrote:
>> > Hi,
>> >
>> > is there a way to get the mac address of the station that sent the
>> > bat_packet? We want to get hold of parameters such as signal strength. We
>> > could do this by using the radiotap header, or by looking at the iw
>> > station
>> > dump of a neighbour. The second option requires the use of the mac
>> > address.
>>
>> Hm? What is a bat_packet? And the sender is encoded in the ethernet mac
>> header before any batman-adv header fields.
>
> Ok, next time please write that you are speaking about batmand. But it is
> still the same. The mac is part of the ethernet mac header at the beginning of
> the frame.
>
> Kind regards,
>         Sven



-- 
If you are going to achieve excellence in big things, you develop the
habit in little matters. Excellence is not an exception, it is a
prevailing attitude.
Colin Powell
