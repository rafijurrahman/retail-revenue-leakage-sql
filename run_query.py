import sqlite3
import sys
import os

DB_PATH = os.path.join(os.path.dirname(__file__), 'retail_analytics.db')

def execute_query(sql):
    if not os.path.exists(DB_PATH):
        print(f"Error: Database file not found at {DB_PATH}")
        return
        
    conn = sqlite3.connect(DB_PATH)
    cur = conn.cursor()
    try:
        cur.execute(sql)
        cols = [description[0] for description in cur.description] if cur.description else []
        rows = cur.fetchall()
        
        if not cols:
            print("Query executed successfully. No rows returned.")
            conn.commit()
            return
            
        # Calculate col widths
        col_widths = [max(len(str(col)), max((len(str(row[i])) for row in rows), default=0)) for i, col in enumerate(cols)]
        col_widths = [max(w, 8) for w in col_widths]
        
        header_line = " | ".join(f"{col:<{col_widths[i]}}" for i, col in enumerate(cols))
        sep_line = "-+-".join("-" * col_widths[i] for i in range(len(cols)))
        
        print("\n" + header_line)
        print(sep_line)
        for r in rows:
            print(" | ".join(f"{str(val):<{col_widths[i]}}" for i, val in enumerate(r)))
        print(f"\n({len(rows)} row(s) returned)\n")
        
    except Exception as e:
        print(f"\nSQL Error: {e}\n")
    finally:
        conn.close()

if __name__ == '__main__':
    if len(sys.argv) > 1:
        arg = sys.argv[1]
        if os.path.isfile(arg):
            with open(arg, 'r', encoding='utf-8') as f:
                query = f.read()
        else:
            query = " ".join(sys.argv[1:])
        execute_query(query)
    else:
        print("--- Interactive SQL Terminal (type 'exit' to quit) ---")
        print("Connected to:", DB_PATH)
        while True:
            try:
                line = input("SQL> ")
                if line.strip().lower() in ['exit', 'quit', 'q']:
                    break
                if not line.strip():
                    continue
                execute_query(line)
            except (KeyboardInterrupt, EOFError):
                break
