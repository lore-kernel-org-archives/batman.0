Return-Path: <xbing6@gmail.com>
From: Xuebing Wang <xbing6@gmail.com>
Message-ID: <f353223e-4902-6eba-c655-36d46d07c892@gmail.com>
Date: Fri, 2 Jun 2017 14:57:18 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [B.A.T.M.A.N.]  [batman-adv] one edge case with 40+ neighbors
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

Hi Simon, Sven,

Thanks for your excellent help. We have 50+ sites (and a total of 1000+ 
nodes running in the field) for over a month, and batman-adv works 
perfectly, maybe I wasn't notified, but I did not hear a single failure.

We have an edge case:
Our nodes are relatively closely placed, which results in 40+ neighbors 
for each node. And batman-adv seemingly does not work for this edge 
case. The issue may be that with this many 40+ neighbors, and neighbors' 
neighbors, ... it is complicated to calculate the route, is this the 
possible cause?

The resolution I can think of is that we can choose the best 12 or so 
(configurable) neighbors (based on signal strength). Is this choosing 
configurable 12 or so best neighbors the best approach? I can try to 
make the change, and upstream for your code-review / merge.

Thanks again.

Xuebing Wang

