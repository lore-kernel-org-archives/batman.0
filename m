Return-Path: <dominicfollett@gmail.com>
MIME-Version: 1.0
Date: Thu, 4 Oct 2012 18:21:02 +0200
Message-ID: <CA+h5VgqB82br1u9Cdg423Eedd8m23wMO=PWo86q+TTAXVtuy8Q@mail.gmail.com>
From: Dominic Follett-Smith <dominicfollett@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] mac address from packet
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

Hi,

is there a way to get the mac address of the station that sent the bat_packet?
We want to get hold of parameters such as signal strength. We could do
this by using the radiotap header, or by looking at the iw station
dump of a neighbour. The second option requires the use of the mac
address.

Regards
Dominic
UCT, SA

-- 
If you are going to achieve excellence in big things, you develop the
habit in little matters. Excellence is not an exception, it is a
prevailing attitude.
Colin Powell
