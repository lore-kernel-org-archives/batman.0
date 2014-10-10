Return-Path: <booray@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5383000.xXB04C6BSt@prime>
References: <CAKKX4kEYFJoSQLndrvP7E1pYP7PehPitWkTjv38bEG9iT-tjng@mail.gmail.com>
 <5383000.xXB04C6BSt@prime>
Date: Fri, 10 Oct 2014 14:28:53 -0700
Message-ID: <CAA51LVqTsRA_mKTHDDycgTp6xfcUq4-5zM806BgQfZDV4MhagA@mail.gmail.com>
From: Ray Gibson <booray@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] batman-adv bonding feature - unable to get data
 packets fragmented into multiple wireless interfaces
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Fri, Oct 10, 2014 at 12:03 PM, Simon Wunderlich
<sw@simonwunderlich.de> wrote:
> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2014-August/012382.html

Previously rejected, trying again, not from mobile device this time!

Related to this, I had some great success testing the patches in my
experimental VM setup but have not yet had a chance to test in real
world conditions.

Simon, I did want to note that watching ifstat on iperf testing with
batman-adv sitting on top of two equally matched Ethernet adapters
split the outgoing traffic fantastically, though the
response/ack/whatever packets to that session consistently came in on
a single adapter that occasionally bounced around, much like what the
sending traffic was doing previously.  I would imagine the other side,
running on the same software, should have equally split that traffic
as well.

Thanks,

Ray
