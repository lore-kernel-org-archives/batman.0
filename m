Return-Path: <thomas.jarosch@intra2net.com>
Message-ID: <4EAC49D7.2060609@intra2net.com>
Date: Sat, 29 Oct 2011 20:45:43 +0200
From: Thomas Jarosch <thomas.jarosch@intra2net.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Logic bug in B.A.T.M.A.N. advanced driver
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hi Marek,

Consider this code from "net/batman-adv/bitarray.c":

int bit_get_packet(void *priv, unsigned long *seq_bits,
		    int32_t seq_num_diff, int set_mark)
{
        ...

	if ((seq_num_diff >= TQ_LOCAL_WINDOW_SIZE)
		|| (seq_num_diff < EXPECTED_SEQNO_RANGE)) {
		bat_dbg(DBG_BATMAN, bat_priv,
			"We missed a lot of packets (%i) !\n",
			seq_num_diff - 1);
		bit_reset_window(seq_bits);
		if (set_mark)
			bit_mark(seq_bits, 0);
		return 1;
	}
-----------------------------------

The defines from "main.h":
#define TQ_LOCAL_WINDOW_SIZE 64
#define EXPECTED_SEQNO_RANGE	65536


So that if() statement will translate to:

-----------------------------------
	if ((seq_num_diff >= 64)
		|| (seq_num_diff < 65536)) {
-----------------------------------

and this will always evaluate to true.

Detected by "cppcheck":
"[net/batman-adv/bitarray.c:157]: (warning) Mutual exclusion over ||
always evaluates to true. Did you intend to use && instead?"

Cheers,
Thomas
