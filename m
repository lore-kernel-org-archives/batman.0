Return-Path: <me@irrelefant.net>
References: <20180505153020.29636-1-linus.luessing@c0d3.blue>
From: me <me@irrelefant.net>
Message-ID: <119878b4-7ad8-9681-03cc-9c470e1c14a6@irrelefant.net>
Date: Wed, 9 May 2018 17:08:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180505153020.29636-1-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset="utf-8"
Content-Language: de-LU
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix TT sync flags for
 intermediate TT responses
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

I recently did a little experimentation on finding the "bad" (gluon)
nodes from a perspective of the vpn gateways with help of the tool
tshark. To document those procedure a little, I'll write it down in this
mail.

Starting point: we have a trace of the mesh-vpn interface from gateway
with the MAC 88:e6:40:20:50:01 which is named foo.pcap. (~10 sec)

As gluon nodes do not use the "isolation" flag of the translation
tables, the isolation flag is a good indicator to find affected packets.
Because the flag is only obviously only inside the TT response packets,
we need to filter for those. "(batadv.tvlv.tt.flags.type == 0x4) &&
(batadv.tvlv.tt.change.flags.isolate == 1)"

The next issue, when we use only the filters above is, that we see
forwarded responses twice, so we add a filter to only see the incomming
responses. To which node the response is forwarded is not really
important as those nodes are not the affected ones. So we add the filter
"(eth.dst == 88:e6:40:20:50:01)" to filter the packets directly
designated for us.

Now we can get the nexthop from which we are receiving the bad packets
by observing "eth.src". To sum it up, the following command is useful
for us:

tshark -r foo.pcap  -Y "(batadv.tvlv.tt.flags.type == 0x4) \
  && (batadv.tvlv.tt.change.flags.isolate == 1) \
  && (eth.dst == 88:e6:40:20:50:01)" \
  -e "eth.src" -Tfields | sort | uniq -c | sort -n

In my case, the output looks like this:

      2 2e:3a:10:c2:4e:5f
      2 88:e6:40:20:20:01
      5 88:e6:40:20:40:01
      9 ba:50:eb:56:50:97
     11 12:b7:57:22:e7:9f
     68 88:e6:40:20:70:01
    129 9e:b9:ba:ee:7e:9f
    194 96:c5:90:5a:1e:6f
    216 6e:34:7f:a4:90:a7
    338 88:e6:40:20:60:01

So we received 974 bad packets in the capture time. The MACs
88:e6:40:XX:XX:XX are the MACs of the other gateways, so we do not
consider them for now, as our aim is to find the bad freifunk routers
connected to this gateway.

Lets focus for now on the node 96:c5:90:5a:1e:6f. We now want to figure
out, which node is the originating node of the TT responses. So the
first idea would be to use the "batadv.unicast_tvlv.src" field of the
packages from 96:c5:90:5a:1e:6f. But this is not the originating node of
the response as intermediate nodes (which maybe answer the query) will
send the responses on behalf of the node for which they are answering.
So from "batadv.unicast_tvlv.src" we only receive the information, which
node was the target of the corresponding request and not which node
answered. But this information is valuable also as the bad node has to
be in the path between our nextnode (96:c5:90:5a:1e:6f) and the query
target. We may use this command:

tshark -r foo.pcap  -Y "(batadv.tvlv.tt.flags.type == 0x4) \
  && (batadv.tvlv.tt.change.flags.isolate == 1) \
  && (eth.dst == 88:e6:40:20:50:01) \
  && (eth.src == 96:c5:90:5a:1e:6f)" \
  -e "batadv.unicast_tvlv.src" -Tfields | sort | uniq -c | sort -n

In my dump the result of the command is:

      1 7a:25:0e:c4:c1:93
      2 02:a8:70:84:9d:fb
    191 4a:87:fc:b6:1d:fb

The interpretation of the result is, that there are 3 nodes which for
which we receive bad packets from the nextnode. So the bad node has to
somewhere between 96:c5:90:5a:1e:6f and one of the three nodes.

Kind regards,
Leonardo Mörlein
