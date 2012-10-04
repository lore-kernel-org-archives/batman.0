Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <CA+h5VgqB82br1u9Cdg423Eedd8m23wMO=PWo86q+TTAXVtuy8Q@mail.gmail.com>
References: <CA+h5VgqB82br1u9Cdg423Eedd8m23wMO=PWo86q+TTAXVtuy8Q@mail.gmail.com>
Date: Thu, 4 Oct 2012 13:38:13 -0300
Message-ID: <CAHD-aq+Uy6jOEbxmE8Tymu5wTsVMaVtDSOdWEJ0BujAVe2s3Dw@mail.gmail.com>
From: Gui Iribarren <gui@altermundi.net>
Content-Type: text/plain; charset=UTF-8
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

AFAIU batman is unaware of the PHY layer mac address, so your only
option is sniffing that out of a pcap dump.

Or, i misundestood your objective. Can you explain a little bit more
what you're trying to do?

On 10/4/12, Dominic Follett-Smith <dominicfollett@gmail.com> wrote:
> Hi,
>
> is there a way to get the mac address of the station that sent the
> bat_packet?
> We want to get hold of parameters such as signal strength. We could do
> this by using the radiotap header, or by looking at the iw station
> dump of a neighbour. The second option requires the use of the mac
> address.
>
> Regards
> Dominic
> UCT, SA
>
> --
> If you are going to achieve excellence in big things, you develop the
> habit in little matters. Excellence is not an exception, it is a
> prevailing attitude.
> Colin Powell
>
