Return-Path: <gui@altermundi.net>
Message-ID: <52995D10.5000907@altermundi.net>
Date: Sat, 30 Nov 2013 00:35:44 -0300
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
References: <CAAxzKbSBjtJ2HGr0AUqQsysDjrrvuCtS6jb1tKbUmpk-B1CeMw@mail.gmail.com>
In-Reply-To: <CAAxzKbSBjtJ2HGr0AUqQsysDjrrvuCtS6jb1tKbUmpk-B1CeMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Loss of connection to remote nodes,
 from clients only.
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
To: b.a.t.m.a.n@lists.open-mesh.org

On 11/24/2013 08:36 PM, tjhowse wrote:
> In my test system I have 11 dual-channel nodes. The 5GHz link is used
> for interconnect between the nodes and the 2.4GHz link is for clients.
> One of the nodes is distant. My laptop is connected to a common-SSID
> AP link from one of the local nodes. I can always ping the distant
> node from one of the local nodes, but the link from my laptop is less
> reliable. I can have an SSH session open to the distant node and a
> local node, pinging the distant node from both the local node and my
> laptop. At no particular point the distant node will stop pinging from
> my laptop and its SSH session will drop, while the ping continues just
> fine from the local node.
>
> The connection can restore equally mysteriously.
>
> Can anyone explain this behavior? No manual network configuration
> changes are being made at the point at which the connection drops or
> is restored, though I suppose my laptop could be hopping between one
> of the local APs. I am pinging an IP attached to the bridge joining
> bat0, the copper node LAN and the 2.4GHz client LAN.

Which batman-adv version are you using?

i've seen a similar behaviour on 2013.1.0 and 2013.2.0, related to TTVN, 
but never collected data clean enough to report it, and then 2013.4.0 
came out.
i'll test this week 2013.4.0 to see if it's still an issue.

