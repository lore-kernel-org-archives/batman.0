Return-Path: <ordex@autistici.org>
Date: Mon, 15 Aug 2011 18:29:32 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110815162931.GB7493@ritirata.org>
References: <mailman.1.1313229601.6855.b.a.t.m.a.n@lists.open-mesh.org>
	<4E494147.5020709@inti.gob.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4E494147.5020709@inti.gob.ar>
Subject: Re: [B.A.T.M.A.N.] Multiple DHCP Gateways
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

On Mon, Aug 15, 2011 at 12:54:47PM -0300, gtolon@inti.gob.ar wrote:
> Thank you for your answers. I understood clearly how the system should 
> work, but i´m not using the git repository but the 2011.1.0 version. 

Ah ok, then everything is ok with your description: successive DHCP requests are
sent in unicast and so to they are sent to the old GW, even if the node serving
the client just chose a new GW.

Please, feel free to share your experience with the git version :-)

Regards,
Antonio
