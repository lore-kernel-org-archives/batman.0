Return-Path: <dbeberman@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4DF9CAE3.8020709@tiwoc.de>
References: <BANLkTi=HCdWDjTQER8uOP48RW-XsZ6ehaQ@mail.gmail.com>
	<4DF9CAE3.8020709@tiwoc.de>
Date: Thu, 16 Jun 2011 09:21:39 -0400
Message-ID: <BANLkTinoSx+SA-NGjZRwfmehbLMZQqOy9w@mail.gmail.com>
From: David Beberman <dbeberman@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] tangentially driver related question on
 broadcasts with batman-adv
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
To: Daniel Seither <post@tiwoc.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi Dan,

So far, with Linux, I have only used the iwconfig and iw tools.
For one of the drivers, using iwconfig, I was able to set the data rate,
which was used for broadcasts.  I could set the data rate to both
802.11b and 802.11g rates.  However, the hardware would send
a CTS frame and apparently an 802.11g frame with what appears
to be corruption giving a CRC error for all 802.11g rates.  This only
occurred when a node detects the presence of other nodes operating
at 802.11b/g, which corresponds to 802.11n coexistence behavior.
Not what I was expecting.
For other drivers, I was unable to get anything but 1 Mbps broadcasts.
As I think this is useful for floodfill types of data traffic
requirements, as opposed
to unicast or multicast, my next step is to take a look at the Linux
MAC80211 layer.  This is very much a "corner case" use for mesh
networks, but I happen to need it.  Still hoping for a simple solution
to this.

David

On Thu, Jun 16, 2011 at 5:20 AM, Daniel Seither <post@tiwoc.de> wrote:
> Hi!
>
> Am 16.06.2011 00:04, schrieb David Beberman:
>> The second way I'm using it is to take advantage of broadcasting
>> as a simply floodfill algorithm. =A0All of my nodes transmit to all othe=
r nodes
>> on a periodic basis. =A0This is an IPv6 local multicast. =A0I believe th=
is
>> translates to 802.11 MAC FF:FF:FF:FF:FF:FF broadcast address, and
>> everything works.
>>
>> What I noticed with a network sniffer is that all of the broadcasts were=
 sent
>> with 1 Mbps data rate.
>
> This is the behavior specified in IEEE 802.11 [1], =A79.6 (Multirate supp=
ort):
> "All frames with multicast and broadcast in the Address 1 field that
> have a UP of zero shall be transmitted at one of the rates included in
> the BSSBasicRateSet parameter, regardless of their type or subtype."
>
> The basic rate set seems to often consists only of small rates such as 1
> or 2 MBit/s in 11g networks. However, I couldn't find out how to get the
> basic rates supported by my wifi card or configured in the wireless
> stack. Does anyone know how to do this?
>
> - Daniel
>
> [1] http://standards.ieee.org/getieee802/download/802.11-2007.pdf
>
